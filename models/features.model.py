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
from torchvision.models import resnet50, ResNet50_Weights
from PIL import Image
from tqdm import tqdm

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")

csv_path = "myntradataset/finalDataSets.csv"
image_folder = "myntradataset/FinalImages"
IMG_SIZE = (224, 224)
BATCH_SIZE = 16
EPOCHS = 3

df = pd.read_csv(csv_path, usecols=range(10), on_bad_lines='warn')
df["id"] = df["id"].astype(str) + ".jpg"

label_columns = ['gender','masterCategory','subCategory','articleType','baseColour','season','usage']
label_encoders = {}
for col in label_columns:

    
    le = LabelEncoder()
    df[col] = le.fit_transform(df[col])
    label_encoders[col] = le

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
        return image, torch.tensor(label)

transform = transforms.Compose([
    transforms.Resize(IMG_SIZE),
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(10),
    transforms.ColorJitter(brightness=0.2, contrast=0.2, saturation=0.2, hue=0.1),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

def collate_fn(batch):
    batch = [item for item in batch if item[0] is not None]
    images, labels = zip(*batch)
    return torch.stack(images, dim=0), torch.tensor(labels)

class SingleOutputResNet(nn.Module):
    def __init__(self, base_model, num_classes):
        super(SingleOutputResNet, self).__init__()
        self.backbone = nn.Sequential(*list(base_model.children())[:-1])
        self.dropout = nn.Dropout(0.5)
        self.fc = nn.Linear(base_model.fc.in_features, num_classes)

    def forward(self, x):
        x = self.backbone(x)
        x = torch.flatten(x, 1)
        x = self.dropout(x)
        x = self.fc(x)
        return x

if __name__ == "__main__":
    for label_col in label_columns:
        print(f"\nTraining for label: {label_col}")

        train_df = df.sample(frac=0.8, random_state=42)
        val_df = df.drop(train_df.index)

        train_dataset = CustomImageDataset(train_df, image_folder, label_col, transform=transform)
        val_dataset = CustomImageDataset(val_df, image_folder, label_col, transform=transform)

        train_loader = DataLoader(train_dataset, batch_size=BATCH_SIZE, shuffle=True, collate_fn=collate_fn, num_workers=6)
        val_loader = DataLoader(val_dataset, batch_size=BATCH_SIZE, shuffle=False, collate_fn=collate_fn, num_workers=6)

        num_classes = len(label_encoders[label_col].classes_)
        base_model = models.resnet50(weights=ResNet50_Weights.DEFAULT)
        model = SingleOutputResNet(base_model, num_classes).to(device)

        def init_weights(m):
            if isinstance(m, nn.Linear):
                nn.init.xavier_uniform_(m.weight)
                nn.init.zeros_(m.bias)

        model.apply(init_weights)

        criterion = nn.CrossEntropyLoss()
        optimizer = optim.Adam(model.parameters(), lr=0.0001)
        scheduler = optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='max', patience=2, factor=0.5)
        scaler = torch.cuda.amp.GradScaler()

        train_acc_history = []
        val_acc_history = []

        for epoch in range(EPOCHS):
            model.train()
            running_loss = 0.0
            correct = 0
            total = 0

            for inputs, labels in tqdm(train_loader, desc=f"Epoch {epoch+1}/{EPOCHS} Training {label_col}", leave=False):
                inputs = inputs.to(device)
                labels = labels.to(device)

                optimizer.zero_grad()
                with torch.cuda.amp.autocast():
                    outputs = model(inputs)
                    loss = criterion(outputs, labels)

                scaler.scale(loss).backward()
                scaler.step(optimizer)
                scaler.update()

                running_loss += loss.item()
                preds = torch.argmax(outputs, 1)
                correct += (preds == labels).sum().item()
                total += labels.size(0)

            train_acc = correct / total
            train_acc_history.append(train_acc)
            print(f"Epoch [{epoch+1}/{EPOCHS}], Loss: {running_loss/len(train_loader):.4f}, Train Accuracy: {train_acc:.4f}")

            model.eval()
            correct = 0
            total = 0
            with torch.no_grad():
                for inputs, labels in val_loader:
                    inputs = inputs.to(device)
                    labels = labels.to(device)
                    outputs = model(inputs)
                    preds = torch.argmax(outputs, 1)
                    correct += (preds == labels).sum().item()
                    total += labels.size(0)

            val_acc = correct / total
            val_acc_history.append(val_acc)
            print(f"Validation Accuracy: {val_acc:.4f}")
            scheduler.step(val_acc)

        test_acc = val_acc
        print(f"Test Accuracy for {label_col}: {test_acc:.4f}")

        # Plotting
        fig, axes = plt.subplots(1, 2, figsize=(14, 6))
        axes[0].plot(train_acc_history, label='Train Accuracy')
        axes[0].plot(val_acc_history, label='Validation Accuracy')
        axes[0].set_title(f"Accuracy Curve - {label_col}")
        axes[0].set_xlabel("Epochs")
        axes[0].set_ylabel("Accuracy")
        axes[0].legend()

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
        table = axes[1].table(cellText=[[param] for param in hyperparameters], loc='center', cellLoc='left')
        table.auto_set_font_size(False)
        table.set_fontsize(10)
        table.scale(1.5, 1.5)
        axes[1].axis('off')
        plt.tight_layout()
        plt.show()

        # Save model
        torch.save(model.state_dict(), f"model_{label_col}.pth")
        print(f"Model for {label_col} saved successfully!\n")
