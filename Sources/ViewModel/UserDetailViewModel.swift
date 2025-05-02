//
//  UserDetailViewModel.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

final class UserDetailViewModel: UserDetailViewModelProtocol {
    private let service: GitHubServiceProtocol
    private(set) var userDetail: UserDetail?
    private(set) var repositories: [Repository] = []
    var onRepositoriesUpdated: (() -> Void)?

    private var currentPage = 1
    private let perPage = 30
    private(set) var hasMoreRepos = true

    init(service: GitHubServiceProtocol) {
        self.service = service
    }

    func fetchUserDetail(username: String) -> Promise<Void> {
        return Promise { seal in
            let url = "https://api.github.com/users/\(username)"
            AF.request(url)
                .validate()
                .responseDecodable(of: UserDetail.self) { response in
                    switch response.result {
                    case .success(let detail):
                        self.userDetail = detail
                        do {
                            let data = try JSONEncoder().encode(detail)
                            UserDefaults.standard.set(data, forKey: "cachedDetail_\(username)")
                        } catch {
                            print("Erro ao salvar detalhe em cache")
                        }
                        seal.fulfill(())
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func fetchRepositories(for username: String) -> Promise<Void> {
        guard hasMoreRepos else { return .value(()) }

        return Promise { seal in
            let url = "https://api.github.com/users/\(username)/repos?page=\(currentPage)&per_page=\(perPage)"
            AF.request(url)
                .validate()
                .responseDecodable(of: [Repository].self) { response in
                    switch response.result {
                    case .success(let repos):
                        self.repositories.append(contentsOf: repos)
                        self.onRepositoriesUpdated?()
                        self.hasMoreRepos = repos.count == self.perPage
                        if self.hasMoreRepos { self.currentPage += 1 }

                        do {
                            let data = try JSONEncoder().encode(self.repositories)
                            UserDefaults.standard.set(data, forKey: "cachedRepos_\(username)")
                        } catch {
                            print("Erro ao salvar repositórios em cache")
                        }

                        seal.fulfill(())
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
}
