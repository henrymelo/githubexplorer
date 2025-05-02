
## [1.0.1] - 2025-04-30

### 🔧 Correções de Compatibilidade

- Removido uso incorreto de `.prefix(10)` em `Date`
- Uso de `defaultContentConfiguration()` e `contentConfiguration` protegido com `#available(iOS 14.0, *)`
- Compatibilidade garantida com iOS 14.3+

# 📜 Changelog

Todas as mudanças notáveis neste projeto estão documentadas aqui.

---

## [1.0.0] - 2025-04-30

### ✨ Funcionalidades
- Listagem de usuários com foto e nome
- Tela de detalhes do usuário com nome, bio, seguidores e seguindo
- Listagem e detalhes dos repositórios
- Suporte à busca por usuários
- Arquitetura MVVM com Coordinator
- View Code puro com UIKit + SnapKit
- Cache local de repositórios
- UI Responsiva com suporte a modo escuro

### 🧪 Testes
- Testes unitários com Quick/Nimble para ViewModels
- Testes de UI com XCTest
- Simulação de busca com flag `-mockSearchResults`

### 🔧 Infraestrutura
- Projeto gerado com XcodeGen
- Gerenciamento de dependências via CocoaPods
- CI com GitHub Actions
- Script `setup.sh` para automatização do ambiente

### 🛠️ Compatibilidade
- Desenvolvido e validado com **Xcode 16.2**
- Compatível com **iOS 14.3 ou superior**

---

