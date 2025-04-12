import torch
from torchvision import transforms, models
from PIL import Image
import requests
from io import BytesIO
import numpy as np
from sklearn.preprocessing import LabelEncoder
import warnings
warnings.filterwarnings("ignore")

# Ensure you have the correct device (GPU or CPU)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# Load the trained model (same architecture as when trained)
model = models.resnet50(pretrained=False)  # Define the model architecture
model.fc = torch.nn.Sequential(
    torch.nn.Linear(model.fc.in_features, 512),
    torch.nn.ReLU(),
    torch.nn.Linear(512, 73),
    torch.nn.LogSoftmax(dim=1)
)
model.load_state_dict(torch.load("model.pth"))  # Load the saved model weights
model = model.to(device)
model.eval()  # Set the model to evaluation mode

# Preprocess the image (same as when training)
def preprocess_image(image):
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
    ])
    image = transform(image).unsqueeze(0)  # Add batch dimension (1, 3, 224, 224)
    return image

label_encoder = LabelEncoder()

# Function to make prediction
def predict(image):
    image_tensor = preprocess_image(image)
    image_tensor = image_tensor.to(device)
    
    with torch.no_grad():
        outputs = model(image_tensor)
    
    _, predicted_class = torch.max(outputs, 1)
    predicted_label = label_encoder.inverse_transform([predicted_class.item()])[0]
    return predicted_label

# Ask the user for the image URL
image_url = input("Please enter the URL to the image you want to classify: ")

# Fetch the image from the URL
response = requests.get(image_url)
image = Image.open(BytesIO(response.content)).convert("RGB")

# Call the predict function
result = predict(image)
print(f"Predicted Label: {result}")
