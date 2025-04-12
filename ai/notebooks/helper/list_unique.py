import pandas as pd
from dotenv import load_dotenv
import os
import warnings

warnings.filterwarnings("ignore")
load_dotenv()
csv_path = os.getenv("csv_path")

# Load the CSV file
df = pd.read_csv(csv_path, usecols=range(10), on_bad_lines='warn')

# Create and save Master Categories DataFrame
master_df = pd.DataFrame(df["masterCategory"].unique(), columns=["Master Category"])
master_df.to_csv("master_categories.csv", index=False)
print("\nMaster Categories saved to 'master_categories.csv'")

# Create and save Subcategories DataFrame
subcategory_data = []
for category in df["masterCategory"].unique():
    subcategories = df[df["masterCategory"] == category]["subCategory"].unique()
    for sub in subcategories:
        subcategory_data.append([category, sub])

subcategory_df = pd.DataFrame(subcategory_data, columns=["Master Category", "Subcategory"])
subcategory_df.to_csv("subcategories.csv", index=False)
print("\nSubcategories saved to 'subcategories.csv'")

# Create and save Article Types DataFrame
article_type_data = []
for subcategory in df["subCategory"].unique():
    article_types = df[df["subCategory"] == subcategory]["articleType"].unique()
    for article in article_types:
        article_type_data.append([subcategory, article])

article_type_df = pd.DataFrame(article_type_data, columns=["Subcategory", "Article Type"])
article_type_df.to_csv("article_types.csv", index=False)
print("\nArticle Types saved to 'article_types.csv'")
