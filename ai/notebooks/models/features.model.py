import os
import numpy as np
import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset
from torchvision import transforms, models
from sklearn.preprocessing import LabelEncoder
import matplotlib.pyplot as plt
from PIL import Image
from tqdm import tqdm
#import warnings
#warnings.filterwarnings("ignore")


# Check GPU availability
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")

# Paths and constants
csv_path = "myntradataset/filtered_styles.csv"
image_folder = "myntradataset/filtered_images"
IMG_SIZE = (224, 224)
BATCH_SIZE = 24
EPOCHS = 6

# Load CSV file
df = pd.read_csv(csv_path, usecols=range(10), on_bad_lines='warn')

# Convert 'id' to string and add '.jpg' extension
df["id"] = df["id"].astype(str) + ".jpg"

# Encode labels
label_column = 'articleType'
label_encoder = LabelEncoder()
df[label_column] = label_encoder.fit_transform(df[label_column])

# Custom dataset class
class CustomImageDataset(Dataset):
    def __init__(self, dataframe, image_folder, label_column, transform=None):
        self.dataframe = dataframe
        self.image_folder = image_folder
        self.label_column = label_column
        self.transform = transform

    def __len__(self):
        return len(self.dataframe)

    def __getitem__(self, idx):
        img_name = os.path.join(self.image_folder, self.dataframe.iloc[idx, 0])
        
        if not os.path.exists(img_name):
            return None, None

        image = Image.open(img_name).convert("RGB")
        label = int(self.dataframe.iloc[idx][self.label_column])

        if self.transform:
            image = self.transform(image)

        return image, label

# Data transformations
transform = transforms.Compose([
    transforms.Resize(IMG_SIZE),
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(10),
    transforms.ColorJitter(brightness=0.2, contrast=0.2, saturation=0.2, hue=0.1),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Split data into training and validation
train_df = df.sample(frac=0.8, random_state=42)
val_df = df.drop(train_df.index)

train_dataset = CustomImageDataset(train_df, image_folder, label_column, transform=transform)
val_dataset = CustomImageDataset(val_df, image_folder, label_column, transform=transform)

# Function to skip None values in batch
def collate_fn(batch):
    batch = [item for item in batch if item[0] is not None]
    images, labels = zip(*batch)
    return torch.stack(images, dim=0), torch.tensor(labels)
if __name__ == "__main__":
    # DataLoader setup
    train_loader = DataLoader(train_dataset, batch_size=BATCH_SIZE, shuffle=True, collate_fn=collate_fn ,num_workers=6)
    val_loader = DataLoader(val_dataset, batch_size=BATCH_SIZE, shuffle=False, collate_fn=collate_fn , num_workers=6)

    # Check number of classes
    num_classes = len(label_encoder.classes_)
    print("Number of classes:", num_classes)

    # Load Pretrained ResNet50
    model = models.resnet50(pretrained=True)

    # Unfreeze last layers for fine-tuning
    for param in model.layer4.parameters():
        param.requires_grad = True

    for param in model.parameters():
        model = model.to(device)
        if param.device == "cpu":
            model = model.to(device)
        #print(param.device)

    # Modify classifier layer
    model.fc = nn.Sequential(
        nn.Linear(model.fc.in_features, 512),
        nn.ReLU(),
        nn.Linear(512, num_classes),
        nn.LogSoftmax(dim=1)
    )

    # Xavier weight initialization
    def init_weights(m):
        if isinstance(m, nn.Linear):
            nn.init.xavier_uniform_(m.weight)
            nn.init.zeros_(m.bias)

    model.fc.apply(init_weights)

    # Move model to GPU
    model = model.to(device)

    # Loss function and optimizer
    criterion = nn.NLLLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.0001)

    # ReduceLROnPlateau Scheduler
    scheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='max', patience=2, factor=0.5, verbose=True)

    # Mixed precision for faster training
    scaler = torch.cuda.amp.GradScaler()

    # Training loop
    train_acc_history = []
    val_acc_history = []

    for epoch in range(EPOCHS):
        model.train()
        running_loss = 0.0
        correct = 0
        total = 0

        for inputs, labels in tqdm(train_loader, desc=f"Epoch {epoch+1}/{EPOCHS} Training", leave=False):
            model = model.to(device)
            #print("inputs: ", inputs.device, " outputs: ", labels.device)  # Should print: cuda:0 cuda:0
            if inputs is None or labels is None:
                continue
            #print("test")
            inputs = inputs.to("cuda", non_blocking=True)  # Move inputs to GPU
            labels = labels.to("cuda", non_blocking=True)  # Move labels to GPU

            optimizer.zero_grad()

            with torch.cuda.amp.autocast():  # Enable mixed precision
                outputs = model(inputs)
                loss = criterion(outputs, labels)

            scaler.scale(loss).backward()
            scaler.step(optimizer)
            scaler.update()

            running_loss += loss.item()
            _, predicted = torch.max(outputs, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()

        train_acc = correct / total
        train_acc_history.append(train_acc)
        print(f"Epoch [{epoch+1}/{EPOCHS}], Loss: {running_loss/len(train_loader):.4f}, Train Accuracy: {train_acc:.4f}")

        # Validation step
        model.eval()
        correct = 0
        total = 0
        with torch.no_grad():
            for inputs, labels in val_loader:
                if inputs is None or labels is None:
                    continue

                inputs, labels = inputs.to(device), labels.to(device)

                outputs = model(inputs)
                _, predicted = torch.max(outputs, 1)
                total += labels.size(0)
                correct += (predicted == labels).sum().item()

        val_acc = correct / total
        val_acc_history.append(val_acc)
        print(f"Validation Accuracy: {val_acc:.4f}")

        # Adjust learning rate based on validation accuracy
        scheduler.step(val_acc)

    # Evaluate the model
    model.eval()
    correct = 0
    total = 0
    with torch.no_grad():
        for inputs, labels in val_loader:
            if inputs is None or labels is None:
                continue

            inputs, labels = inputs.to(device), labels.to(device)

            outputs = model(inputs)
            _, predicted = torch.max(outputs, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()

    test_acc = correct / total
    print(f"Test Accuracy: {test_acc:.4f}")

    # Plot training and validation accuracy
    plt.plot(train_acc_history, label='Train Accuracy')
    plt.plot(val_acc_history, label='Validation Accuracy')
    plt.xlabel("Epochs")
    plt.ylabel("Accuracy")
    plt.legend()
    plt.show()


    # Print hyperparameters at the end
    print("\n=== Hyperparameters Summary ===")
    print(f"Device: {device}")
    print(f"Image Size: {IMG_SIZE}")
    print(f"Batch Size: {BATCH_SIZE}")
    print(f"Epochs: {EPOCHS}")
    print(f"Learning Rate: {optimizer.param_groups[0]['lr']}")
    print(f"Optimizer: {optimizer.__class__.__name__}")
    print(f"Loss Function: {criterion.__class__.__name__}")
    print(f"Scheduler: {scheduler.__class__.__name__} (Patience: 2, Factor: 0.5)")
    print(f"Pretrained Model: ResNet50")
    print(f"Number of Classes: {num_classes}")
    print(f"Final Train Accuracy: {train_acc_history[-1]:.4f}")
    print(f"Final Validation Accuracy: {val_acc_history[-1]:.4f}")
    print(f"Final Test Accuracy: {test_acc:.4f}")

    #To show summery of the training :
    # Create a figure for displaying hyperparameters and results
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    # Plot accuracy curves
    axes[0].plot(train_acc_history, label='Train Accuracy')
    axes[0].plot(val_acc_history, label='Validation Accuracy')
    axes[0].set_xlabel("Epochs")
    axes[0].set_ylabel("Accuracy")
    axes[0].legend()

    # Prepare hyperparameter summary as a list of strings
    hyperparameters = [
        f"Device: {device}",
        f"Image Size: {IMG_SIZE}",
        f"Batch Size: {BATCH_SIZE}",
        f"Epochs: {EPOCHS}",
        f"Learning Rate: {optimizer.param_groups[0]['lr']}",
        f"Optimizer: {optimizer.__class__.__name__}",
        f"Loss Function: {criterion.__class__.__name__}",
        f"Scheduler: {scheduler.__class__.__name__} (Patience: 2, Factor: 0.5)",
        f"Pretrained Model: ResNet50",
        f"Number of Classes: {num_classes}",
        f"Final Train Accuracy: {train_acc_history[-1]:.4f}",
        f"Final Validation Accuracy: {val_acc_history[-1]:.4f}",
        f"Final Test Accuracy: {test_acc:.4f}"
    ]

    # Display hyperparameters as a table in the second subplot
    table = axes[1].table(cellText=[[param] for param in hyperparameters], loc='center', cellLoc='left')
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1.5, 1.5)

    # Hide axes on the second subplot (since we are displaying a table)
    axes[1].axis('off')

    # Adjust layout and display
    plt.tight_layout()
    plt.show()

    print("Do you want to save the model parameters? (yes/no)")
    answer = input().strip().lower()

    if answer in ["yes", "y", "1"]:
        torch.save(model.state_dict(), "model.pth")
        print("Model saved successfully!")
    else:
        print("See you later!")