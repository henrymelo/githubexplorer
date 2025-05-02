import Quick

class TestSuiteConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        configuration.beforeSuite {
            print("🔧 [TestSuite] Iniciando a suíte de testes...")
            // Setup global, como limpar banco, mocks etc.
        }

        configuration.afterSuite {
            print("✅ [TestSuite] Todos os testes foram executados.")
        }
    }
}
