#!/bin/bash

# Certifique-se de estar na raiz do repositório
echo "Criando branch gh-pages..."

# Cria uma branch vazia chamada gh-pages
git checkout --orphan gh-pages
git reset --hard
rm -rf *

# Adiciona um arquivo .nojekyll para evitar conflitos de caminho
echo "# GitHub Pages" > index.html
touch .nojekyll

# Commita e envia a branch
git add .
git commit -m "Inicializa gh-pages com .nojekyll"
git push origin gh-pages

# Volta para a branch principal
git checkout main

echo "✅ Branch gh-pages criada e publicada. Configure o GitHub Pages para usar essa branch."
