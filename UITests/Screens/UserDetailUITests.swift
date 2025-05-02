//
//  UserDetailUITests.swift
//  GitHub ExplorerUITests
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import XCTest

final class UserDetailUITests: XCTestCase {

    func testErrorViewAppearsInUserDetail() {
        let app = XCUIApplication()
        app.launchArguments = ["-simulateError"]
        app.launch()

        let firstCell = app.tables.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 3) {
            firstCell.tap()

            let errorLabel = app.staticTexts["Erro ao carregar detalhes do usuário."]
            let retryButton = app.buttons["Tentar novamente"]

            XCTAssertTrue(errorLabel.waitForExistence(timeout: 3))
            XCTAssertTrue(retryButton.exists)
        } else {
            XCTFail("Nenhuma célula disponível para seleção")
        }
    }
}
