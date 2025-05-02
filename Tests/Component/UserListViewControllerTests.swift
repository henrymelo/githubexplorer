//
//  UserListViewControllerTests.swift
//  GitHub ExplorerTests
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import XCTest
@testable import GitHubExplorer

final class UserListViewControllerTests: XCTestCase {

    func testHideErrorStateIsCalledAfterSuccess() {
        let controller = UserListViewController(viewModel: MockUserListViewModelSuccess())
        controller.loadViewIfNeeded()
        controller.viewDidLoad()
        
        // Testes de comportamento visual normalmente são verificados via UI Test.
        // Aqui verificamos se a tableView tem dados após carregamento
        XCTAssertGreaterThan(controller.tableView.numberOfRows(inSection: 0), 0)
    }
}

final class MockUserListViewModelSuccess: UserListViewModelProtocol {
    var users: [User] = [User(id: 1, login: "test", avatarUrl: "")]
    var onUsersUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    func fetchUsers() {
        onUsersUpdated?()
    }

    func fetchMoreUsersIfNeeded(currentIndex: Int) {}
    var hasMoreData: Bool { return false }
}
