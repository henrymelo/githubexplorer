//
//  UserListViewControllerTests.swift
//  GitHub ExplorerTests
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import XCTest
import PromiseKit
@testable import GitHubExplorer

final class UserListViewControllerTests: XCTestCase {

    func testHideErrorStateIsCalledAfterSuccess() {
        let controller = UserListViewController(viewModel: MockUserListViewModelSuccess())
        controller.loadViewIfNeeded()

        // Força a chamada de onUsersUpdated para popular os dados
        controller.viewModel.onUsersUpdated?()

        XCTAssertGreaterThan(0, 0)
    }
}

final class MockUserListViewModelSuccess: UserListViewModelProtocol {
    func fetchUsers() -> Promise<Void> {
        onUsersUpdated?()
        return Promise.value(())
    }

    func searchUsers(query: String) {
        // Simulado
    }

    func loadCachedUsers() {
        // Simulado
    }

    var users: [User] = [User(id: 1, login: "user1", avatarUrl: "https://example.com/avatar.png")]
    var onUsersUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    var hasMoreData: Bool { return false }

    func fetchMoreUsersIfNeeded(currentIndex: Int) {
        // Simulado
    }
}
