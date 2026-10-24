
from pathlib import Path

import pandas as pd

# Chemin du fichier CSV dans le projet
BASE_DIR = Path(__file__).resolve().parent.parent
fichier = BASE_DIR / "data" / "Sample - Superstore.csv"

if not fichier.exists():
    raise FileNotFoundError(
        f"Fichier introuvable : {fichier}\n"
        "Place le CSV dans le dossier data."
    )

df = pd.read_csv(fichier, encoding="cp1252")

print("Aperçu des données :")
print(df.head())

print("\nDimensions du dataset :")
print(f"Lignes : {df.shape[0]}")
print(f"Colonnes : {df.shape[1]}")

print("\nNoms des colonnes :")
print(df.columns.tolist())

print("\nTypes des données :")
print(df.dtypes)

print("\nValeurs manquantes :")
print(df.isnull().sum())
