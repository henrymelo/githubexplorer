//
//  UserListViewModel.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import PromiseKit

final class UserListViewModel: UserListViewModelProtocol {
    private let service: GitHubServiceProtocol
    var users: [User] = []
    private var isLoading = false
    private var since: Int = 0
    var onUsersUpdated: (() -> Void)?
    var hasMoreData = true

    init(service: GitHubServiceProtocol) {
        self.service = service
    }

    func fetchUsers() -> Promise<Void> {
        guard !isLoading, hasMoreData else { return .value(()) }
        isLoading = true

        return Promise { seal in
            service.fetchUsers(since: since)
                .done { newUsers in
                    self.users.append(contentsOf: newUsers)
                    self.since = newUsers.last?.id ?? self.since
                    self.hasMoreData = !newUsers.isEmpty
                    self.onUsersUpdated?()
                    seal.fulfill(())
                }
                .catch { error in
                    seal.reject(error)
                }
                .finally {
                    self.isLoading = false
                }
        }
    }

    func searchUsers(query: String) {
        let url = "https://api.github.com/search/users"
        let parameters = ["q": query]

        let request = URLRequest(url: URL(string: url + "?q=\(query)")!)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(GitHubUserSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    self.users = decoded.items
                    self.onUsersUpdated?()
                }
            } catch {
                print("Erro ao buscar usuários: \(error)")
            }
        }.resume()
    }

    func loadCachedUsers() {
        if let cachedUsersData = UserDefaults.standard.data(forKey: "cachedUsers") {
            do {
                let cachedUsers = try JSONDecoder().decode([User].self, from: cachedUsersData)
                self.users = cachedUsers
                self.onUsersUpdated?()
            } catch {
                print("Erro ao carregar usuários do cache: \(error)")
            }
        }
    }
}
