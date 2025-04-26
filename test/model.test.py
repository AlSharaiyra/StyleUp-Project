import os
import warnings
import torch
import torch.nn as nn
import torch.nn.functional as F
import joblib
import requests
from PIL import Image
from io import BytesIO
from torchvision import transforms, models

warnings.filterwarnings("ignore")

# Device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")

# Ready labels and their number of classes
num_classes = {
    'gender': 5,
    'masterCategory': 3,
    'subCategory': 18,
    'articleType': 72,
    'baseColour': 47,
    'season': 5,
    'usage': 8
}

# Paths
saved_models_dir = 'saved_models'

# Detect available models and encoders
ready_labels = []
for label_name in num_classes.keys():
    model_path = os.path.join(saved_models_dir, f'model_{label_name}.pth')
    encoder_path = os.path.join(saved_models_dir, f'label_encoder_{label_name}.pkl')
    if os.path.exists(model_path) and os.path.exists(encoder_path):
        ready_labels.append(label_name)

if not ready_labels:
    print("❌ No ready labels found! Please check your 'saved_models' directory.")
    exit()

print(f"✅ Ready labels for prediction: {ready_labels}")

# Image Preprocessing
def preprocess_image(image):
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(
            mean=[0.485, 0.456, 0.406],
            std=[0.229, 0.224, 0.225]
        )
    ])
    return transform(image).unsqueeze(0)

# Model definition (same structure used in training)
class SingleOutputResNet(nn.Module):
    def __init__(self, num_classes):
        super(SingleOutputResNet, self).__init__()
        base_model = models.resnet50(weights=None)
        self.backbone = nn.Sequential(*list(base_model.children())[:-1])
        self.dropout = nn.Dropout(0.5)
        self.fc = nn.Linear(base_model.fc.in_features, num_classes)

    def forward(self, x):
        x = self.backbone(x)
        x = torch.flatten(x, 1)
        x = self.dropout(x)
        x = self.fc(x)
        return x

# Predict a single label
def predict_single_label(image, label_name):
    model_path = os.path.join(saved_models_dir, f'model_{label_name}.pth')
    encoder_path = os.path.join(saved_models_dir, f'label_encoder_{label_name}.pkl')

    model = SingleOutputResNet(num_classes[label_name])
    model.load_state_dict(torch.load(model_path, map_location=device))
    model = model.to(device)
    model.eval()

    label_encoder = joblib.load(encoder_path)

    image_tensor = preprocess_image(image).to(device)

    with torch.no_grad():
        output = model(image_tensor)[0]
        probs = F.softmax(output, dim=0)

    pred_index = torch.argmax(probs).item()

    try:
        pred_label = label_encoder.inverse_transform([pred_index])[0]
        print(f"✅ {label_name}: {pred_label} (Confidence: {probs[pred_index]:.4f})")
    except Exception as e:
        print(f"❌ Error decoding label for {label_name}: {e}")
        pred_label = "Unknown"

    return pred_label

# Get Image (URL input)
image_url = input("\n🌐 Please enter the URL to the image you want to classify:\n> ")

try:
    response = requests.get(image_url)
    response.raise_for_status()

    if 'image' in response.headers['Content-Type']:
        image = Image.open(BytesIO(response.content)).convert("RGB")
    else:
        print("❌ Error: The provided URL does not point to an image.")
        exit()
except Exception as e:
    print(f"❌ Failed to load image: {e}")
    exit()

# Predict for all available labels
print("\n🔮 Predicting labels...")
predictions = {}

for label_name in ready_labels:
    pred_label = predict_single_label(image, label_name)
    predictions[label_name] = pred_label

# Final Results
print("\n🎯 Final Predictions:")
for label, pred in predictions.items():
    print(f"- {label}: {pred}")
