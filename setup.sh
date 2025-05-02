#!/bin/bash

echo "🧹 Limpando DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "🔧 Gerando o projeto com XcodeGen..."
xcodegen

echo "📦 Instalando os pods..."
pod install

echo "🧽 Limpando projeto..."
xcodebuild clean -workspace GitHubExplorer.xcworkspace -scheme GitHubExplorer -sdk iphonesimulator -quiet

echo "🚀 Abrindo o projeto no Xcode..."
open GitHubExplorer.xcworkspace
