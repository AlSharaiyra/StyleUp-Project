import os
import numpy as np
import pandas as pd
import tensorflow as tf
import matplotlib.pyplot as plt
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Flatten, Dense
from tensorflow.keras.optimizers import Adam
from sklearn.preprocessing import LabelEncoder

# Check GPU availability
print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))

# Paths and constants
csv_path = "myntradataset/styles.csv"
image_folder = "myntradataset/images"
IMG_SIZE = (224, 224)
BATCH_SIZE = 4

# Load CSV file
df = pd.read_csv(csv_path, usecols=range(10), on_bad_lines='warn')

# Convert 'id' to string and add '.jpg' extension
df["id"] = df["id"].astype(str) + ".jpg"

# Encode labels
label_column = 'articleType'
label_encoder = LabelEncoder()
df[label_column] = label_encoder.fit_transform(df[label_column])
df[label_column] = df[label_column].astype(str)  # Ensure it's string for ImageDataGenerator

# ImageDataGenerator with a fixed validation split
datagen = ImageDataGenerator(rescale=1./255, validation_split=0.1)

# Train & Validation Generators
train_generator = datagen.flow_from_dataframe(
    dataframe=df,
    directory=image_folder,
    x_col="id",
    y_col=label_column,
    target_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    class_mode="categorical",
    subset="training"
)

test_generator = datagen.flow_from_dataframe(
    dataframe=df,
    directory=image_folder,
    x_col="id",
    y_col=label_column,
    target_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    class_mode="categorical",
    subset="validation"
)


print("Train Generator Classes:", len(train_generator.class_indices))
print("Test Generator Classes:", len(test_generator.class_indices))
print("Unique Labels in DataFrame:", len(df[label_column].unique()))


num_classes = len(train_generator.class_indices)

# Load Pretrained ResNet50
base_model = ResNet50(weights="imagenet", include_top=False, input_shape=(224, 224, 3))

# Freeze base model layers
for layer in base_model.layers:
    layer.trainable = False

# Add custom classification layers
x = Flatten()(base_model.output)
x = Dense(512, activation="relu")(x)
x = Dense(num_classes, activation="softmax")(x)

# Create final model
print("Creating final model")
model = Model(inputs=base_model.input, outputs=x)

# Compile the model
print("Compiling the model")
model.compile(optimizer=Adam(learning_rate=0.0001), loss="categorical_crossentropy", metrics=["accuracy"])

# Model summary
model.summary()

# Train the model
print("Training the model")
history = model.fit(train_generator, validation_data=test_generator, epochs=5)

# Evaluate the model
test_loss, test_acc = model.evaluate(test_generator)
print(f"Test Accuracy: {test_acc:.2f}")

# Plot training history
plt.plot(history.history['accuracy'], label='Train Accuracy')
plt.plot(history.history['val_accuracy'], label='Validation Accuracy')
plt.xlabel("Epochs")
plt.ylabel("Accuracy")
plt.legend()
plt.show()
