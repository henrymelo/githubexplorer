# Contribuindo com o GitHubExplorer

Obrigado por querer contribuir com este projeto!

## 🛠️ Configuração do Ambiente

1. Clone o repositório
2. Instale as dependências com `pod install`
3. Gere o projeto com `xcodegen generate`
4. Abra com `xed .`

## 🔀 Git Flow

- Use o padrão de branches:
  - `main`: versão estável
  - `develop`: integração de features
  - `feature/nome-da-feature`: novas funcionalidades
  - `hotfix/nome-do-hotfix`: correções pontuais

## 📦 Commits

- Padrão recomendado:
  - `feat:` para novas funcionalidades
  - `fix:` para correções
  - `refactor:` para melhorias de código
  - `test:` para testes
  - `chore:` para manutenção

Exemplo:
```
feat: adicionar tela de detalhes do usuário
```

## ✅ Pull Requests

- Sempre aponte para `develop`
- Adicione descrição clara do que foi feito
- Relacione a issue (se aplicável)
- Execute os testes (`⌘+U`) antes de submeter

## 🧪 Testes

- Escreva testes unitários com **Quick/Nimble**
- Use mocks sempre que possível
- Rode `cmd+U` para garantir cobertura

## 💬 Suporte

Em caso de dúvidas, crie uma issue com a tag `help wanted`.

---

Feliz codificação!