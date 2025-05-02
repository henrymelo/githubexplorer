import XCTest

final class GitHubExplorerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testListaDeUsuariosAparece() throws {
        let app = XCUIApplication()
        app.launch()

        app.terminate()
        app.launchArguments += ["-uiTestPagination"]
        app.launch()

        let table = app.tables.firstMatch
        let exists = table.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "A tabela de usuários não apareceu.")
    }

    func testBotaoRetryApareceEmCasoDeErro() throws {
        let app = XCUIApplication()
        app.launchArguments.append("-simulateError")
        app.launch()

        let retryButton = app.buttons[AppStrings.tryAgain]
        let exists = retryButton.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Botão de tentar novamente não apareceu após simulação de erro.")
    }

    func testBuscaDeUsuario() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Campo de busca não encontrado")

        searchField.tap()
        searchField.typeText("octocat")
        app.keyboards.buttons["Search"].tap()

        // Verifica se a lista é atualizada
        app.terminate()
        app.launchArguments += ["-uiTestPagination"]
        app.launch()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5))
        XCTAssertTrue(table.cells.count > 0, "Nenhum resultado retornado para busca")
    }

    func testScrollTriggersPagination() {
        app.terminate()
        app.launchArguments += ["-uiTestPagination"]
        app.launch()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5), "A lista deve existir")

        for _ in 0..<5 {
            let lastCell = table.cells.element(boundBy: table.cells.count - 1)
            if lastCell.exists {
                table.swipeUp()
                sleep(1)
            }
        }

        XCTAssertGreaterThan(table.cells.count, 10, "Scroll infinito deve carregar mais usuários")
    }


    func testDetailScrollTriggersRepositoryPagination() {
        app.terminate()
        app.launchArguments += ["-uiTestPagination"]
        app.launch()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5), "Lista de usuários deve aparecer")

        // Toca no primeiro usuário da lista
        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()

        let detailTable = app.tables.firstMatch
        XCTAssertTrue(detailTable.waitForExistence(timeout: 5), "Tabela de repositórios deve aparecer")

        for _ in 0..<5 {
            let lastCell = detailTable.cells.element(boundBy: detailTable.cells.count - 1)
            if lastCell.exists {
                detailTable.swipeUp()
                sleep(1)
            }
        }

        XCTAssertGreaterThan(detailTable.cells.count, 10, "Scroll deve carregar mais repositórios")
    }

}
