import os
import shutil
import pandas as pd
from dotenv import load_dotenv
load_dotenv()
csv_path = os.getenv("csv_path")
# Load the dataset
df = pd.read_csv(csv_path , usecols=range(10) , on_bad_lines='warn')

# Define categories to REMOVE
master_categories_to_remove = ["Personal Care", "Free Items", "Sporting Goods", "Home"]
sub_categories_to_remove = ["Innerwear", "Loungewear and Nightwear", "Shoe Accessories", "Jewellery", "Eyewear","Wallets", "Sports Accessories","Cufflinks", "Stoles", "Umbrellas", "Perfumes"]  # Example subcategories
article_types_to_remove = ["Water Bottle","Swimwear","Headband"]  # Example article types  

# Filter the dataset
filtered_df = df[
    (~df["masterCategory"].isin(master_categories_to_remove)) & 
    (~df["subCategory"].isin(sub_categories_to_remove)) & 
    (~df["articleType"].isin(article_types_to_remove))
]


# Iterate over the filtered dataset and move images
image_folder = os.getenv("image_folder")   # Original images folder
new_image_folder = "myntradataset/filtered_images" # New folder for filtered images
print(image_folder)
# Create a new folder for filtered images
os.makedirs(new_image_folder, exist_ok=True)

# Create a new filtered DataFrame that only includes images that exist
filtered_records = []

for _, row in filtered_df.iterrows():
    image_filename = f"{row['id']}.jpg"  # Assuming images are in .jpg format
    source_path = os.path.join(image_folder, image_filename)
    destination_path = os.path.join(new_image_folder, image_filename)
    
    if os.path.exists(source_path):  # Check if the image exists
        shutil.move(source_path, destination_path)  # Move image to new folder
        filtered_records.append(row)  # Add row to new filtered dataset

# Convert the updated list to a DataFrame
filtered_df_final = pd.DataFrame(filtered_records)

# Save the new filtered CSV only with existing images
filtered_df_final.to_csv("myntradataset/filtered_styles.csv", index=False)

print(f"✅ Filtering complete! Moved {len(filtered_records)} images. New CSV saved in 'dataset/filtered_styles.csv'.")