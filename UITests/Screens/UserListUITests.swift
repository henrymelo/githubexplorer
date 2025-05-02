//
//  UserListUITests.swift
//  GitHub ExplorerUITests
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import XCTest

final class UserListUITests: XCTestCase {

    func testErrorViewAppearsOnLaunchFailure() {
        let app = XCUIApplication()
        app.launchArguments = ["-simulateError"]
        app.launch()

        let errorLabel = app.staticTexts["Erro ao carregar usuários."]
        let retryButton = app.buttons["Tentar novamente"]

        XCTAssertTrue(errorLabel.waitForExistence(timeout: 3))
        XCTAssertTrue(retryButton.exists)
    }
}
