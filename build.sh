#!/bin/bash

# Script de build pour le projet Quarto
# Destination : Dossier public pour déploiement Vercel

echo "🚀 Démarrage du build..."

# Créer le dossier public s'il n'existe pas
mkdir -p public

# Rendre le fichier Quarto principal (index.qmd)
# Format HTML configuré dans le YAML du fichier
quarto render analyse_nhanes.qmd

# Déplacer le fichier HTML généré vers public
if [ -f  "analyse_nhanes.html" ]; then
    mv analyse_nhanes.html public/
    echo "✅ Fichier analyse_nhanes.html copié."
else
    echo "❌ Erreur : analyse_nhanes.html non généré."
    exit 1
fi

# Copier les dossiers de dépendances (images, scripts, styles)
if [ -d "analyse_nhanes_files" ]; then
    cp -r analyse_nhanes_files public/
    echo "✅ Dépendances analyse_nhanes_files copiées."
fi

# Copier le CSS personnalisé si présent
if [ -f "custom.css" ]; then
    cp custom.css public/
    echo "✅ custom.css copié."
fi

echo "🎉 Build terminé avec succès !"