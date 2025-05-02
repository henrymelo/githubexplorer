# GitHubExplorer

Um projeto iOS desenvolvido com UIKit + View Code, utilizando arquitetura MVVM com Coordinator.  
Integra com a API do GitHub para exibir usuários, seus repositórios e detalhes associados.

---

## ✅ Funcionalidades

- 🔄 Paginação infinita de usuários
- 🦴 Skeleton loading para repositórios
- ⚠️ Alerta de modo offline
- ♿️ Acessibilidade com suporte a VoiceOver
- 🔠 Dynamic Type para tamanhos de fonte do sistema
- 🌗 Suporte ao modo Claro e Escuro
- 📃 **Lista de usuários** com foto e nome
- 🔍 **Busca por usuários**
- 👤 **Detalhes do usuário** com nome, bio, seguidores e seguindo
- 📦 **Lista de repositórios** de cada usuário
- 📁 **Detalhes do repositório** com linguagem, stars, forks, issues, data de atualização e status
- 🌐 Abertura do repositório no navegador (em breve)

---

## 📐 Arquitetura

- `Alamofire` para chamadas de rede
- `AlamofireImage` para carregamento de imagens
- `PromiseKit` para fluxo assíncrono
- `NWPathMonitor` para detecção de rede
- **MVVM** com uso de protocolos para injeção de dependência
- **Coordinator** para navegação desacoplada
- **View Code** com SnapKit (sem storyboard)

---

## 🧪 Testes

- Cobertura com `Codecov`
- Testes com argumento `-simulateError` para falha de rede
- `Quick` e `Nimble` para testes unitários de ViewModels
- `XCTest` para testes de UI
- Suporte ao argumento `-mockSearchResults` para simulação em testes automatizados

---

## 🧱 Requisitos

Este projeto foi desenvolvido e testado com **Xcode 16.2**.

- Xcode **16.2**
- iOS **14.3 ou superior**
- `CocoaPods` para dependências
- `XcodeGen` para geração do projeto

---

## 🚀 Setup

Execute no terminal:

```bash
./setup.sh
```

O script irá:

- Apagar `DerivedData`
- Gerar o `.xcodeproj` via `xcodegen`
- Instalar dependências com `pod install`
- Abrir o projeto no Xcode

---

## 📂 Estrutura

- `Sources/`: código principal
- `Tests/`: testes unitários com mocks
- `UITests/`: testes de interface
- `.github/`: CI com GitHub Actions + templates de issues/PRs

---

## 📦 CI/CD

- Validação de build e testes via GitHub Actions
- Releases automáticos com tag (`v1.0.0`, etc.)

---

## 👨‍💻 Autor

Henry Melo
