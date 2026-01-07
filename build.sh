#!/bin/bash

# Script de build pour le projet Quarto
# Destination : Dossier public pour déploiement Vercel

echo "🚀 Démarrage du build..."

# Créer le dossier public s'il n'existe pas
mkdir -p public

# Essayer de rendre le fichier Quarto si quarto est disponible
if command -v quarto &> /dev/null
then
    echo "🔍 Quarto détecté, rendu du document..."
    quarto render analyse_nhanes.qmd
else
    echo "⚠️  Quarto non trouvé. Utilisation de la version pré-générée."
fi

# Copier le fichier HTML généré vers public en tant que index.html
if [ -f  "analyse_nhanes.html" ]; then
    # On utilise cp au lieu de mv pour garder une copie à la racine si besoin localement
    cp analyse_nhanes.html public/index.html
    echo "✅ Fichier analyse_nhanes.html copié vers public/index.html"
else
    echo "❌ Erreur : analyse_nhanes.html non trouvé et impossible de le générer."
    exit 1
fi

# Copier les dossiers de dépendances si présents (pour les formats non-embedded)
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