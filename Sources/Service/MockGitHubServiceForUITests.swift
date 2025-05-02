//
//  MockGitHubServiceForUITests.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import PromiseKit

final class MockGitHubServiceForUITests: GitHubServiceProtocol {
    private var allUsers: [User] = []
    private var pageSize = 30

    init() {
        for i in 1...150 {
            allUsers.append(User(id: i, login: "user\(i)", avatarUrl: "https://example.com/avatar\(i).png"))
        }
    }

    func fetchUsers() -> Promise<[User]> {
        return Promise.value(Array(allUsers.prefix(pageSize)))
    }

    func fetchUsers(since: Int) -> Promise<[User]> {
        let startIndex = allUsers.firstIndex(where: { $0.id > since }) ?? allUsers.count
        let endIndex = min(startIndex + pageSize, allUsers.count)
        let page = Array(allUsers[startIndex..<endIndex])
        return Promise.value(page)
    }

    func fetchUserDetail(username: String) -> Promise<UserDetail> {
        return Promise.value(
            UserDetail(
                login: username,
                name: "Mock \(username)",
                bio: "Bio for \(username)",
                followers: 42,
                following: 5,
                publicRepos: 10,
                company: "MockCompany",
                location: "MockLocation",
                avatarUrl: "https://example.com/avatar.png"
            )
        )
    }

    func fetchRepositories(for username: String) -> Promise<[Repository]> {
        var repos: [Repository] = []
        for i in 1...30 {
            repos.append(
                Repository(
                    name: "Repo\(i)",
                    description: "Descrição do Repo\(i)",
                    language: "Swift",
                    stargazersCount: 10 + i,
                    forksCount: 5,
                    openIssuesCount: 1,
                    updatedAt: "2023-12-01T00:00:00Z",
                    isPrivate: false,
                    isArchived: false,
                    htmlUrl: "https://github.com/\(username)/Repo\(i)"
                )
            )
        }
        return Promise.value(repos)
    }
}
