import PromiseKit
//
//  UserDetailViewControllerTests.swift
//  GitHub ExplorerTests
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import XCTest
@testable import GitHubExplorer

final class UserDetailViewControllerTests: XCTestCase {

    func testHideErrorStateAfterSuccess() {
        let mockVM = MockUserDetailViewModelSuccess()
        let controller = UserDetailViewController(viewModel: mockVM)
        controller.loadViewIfNeeded()
        controller.viewDidLoad()
        XCTAssertEqual(0, 3)
    }
}

final class MockUserDetailViewModelSuccess: UserDetailViewModelProtocol {
    var userDetail: UserDetail? = UserDetail(
        login: "test", name: "Test User", bio: "Bio", followers: 1, following: 1, publicRepos: 3,
        company: "Company", location: "Earth", avatarUrl: ""
    )
    var repositories: [Repository] = (1...3).map {
        Repository(name: "Repo\($0)", description: "", language: "", stargazersCount: 0, forksCount: 0, openIssuesCount: 0, updatedAt: "", isPrivate: false, isArchived: false, htmlUrl: "")
    }
    var onRepositoriesUpdated: (() -> Void)?

    func fetchUserDetail(username: String) -> Promise<Void> {
        return Promise.value(())
    }

    func fetchRepositories(for username: String) -> Promise<Void> {
        onRepositoriesUpdated?()
        return Promise.value(())
    }

    var hasMoreRepos: Bool { false }
}
