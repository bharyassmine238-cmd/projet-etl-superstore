
from pathlib import Path

import pandas as pd

BASE_DIR = Path(__file__).resolve().parent.parent
fichier = BASE_DIR / "data" / "Sample - Superstore.csv"

if not fichier.exists():
    raise FileNotFoundError(
        f"Fichier introuvable : {fichier}\n"
        "Place le CSV dans le dossier data."
    )

df = pd.read_csv(fichier, encoding="cp1252")

# Conversion des dates
df["Order Date"] = pd.to_datetime(
    df["Order Date"], format="%m/%d/%Y", errors="raise"
)
df["Ship Date"] = pd.to_datetime(
    df["Ship Date"], format="%m/%d/%Y", errors="raise"
)

# Le code postal est un identifiant, pas une quantité
df["Postal Code"] = df["Postal Code"].astype("string")

# Vérifications
print("Dimensions après nettoyage :", df.shape)
print("Nombre de lignes dupliquées :", df["Row ID"].duplicated().sum())
print("Valeurs manquantes :", df.isnull().sum().sum())
print("Période des commandes :")
print(df["Order Date"].min(), "à", df["Order Date"].max())

# Export des données nettoyées dans un fichier local
sortie = BASE_DIR / "data" / "superstore_clean.csv"
df.to_csv(sortie, index=False, encoding="utf-8-sig")
print(f"\nFichier nettoyé créé : {sortie}")
