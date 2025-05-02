//
//  GitHubService.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol GitHubServiceProtocol {
    func fetchUsers() -> Promise<[User]>
    func fetchUsers(since: Int) -> Promise<[User]>
    func fetchUserDetail(username: String) -> Promise<UserDetail>
    func fetchRepositories(for username: String) -> Promise<[Repository]>
}

final class GitHubService: GitHubServiceProtocol {
    func fetchUsers() -> Promise<[User]> {
        return Promise { seal in
            let url = "https://api.github.com/users"
            AF.request(url)
                .validate()
                .responseDecodable(of: [User].self) { response in
                    switch response.result {
                    case .success(let users):
                        seal.fulfill(users)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    func fetchUsers(since: Int) -> Promise<[User]> {
        return Promise { seal in
            let url = "https://api.github.com/users?since=\(since)"
            AF.request(url)
                .validate()
                .responseDecodable(of: [User].self) { response in
                    switch response.result {
                    case .success(let users):
                        seal.fulfill(users)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
    
    func fetchUserDetail(username: String) -> Promise<UserDetail> {
        return Promise { seal in
            let url = "https://api.github.com/users/\(username)"
            AF.request(url)
                .validate()
                .responseDecodable(of: UserDetail.self) { response in
                    switch response.result {
                    case .success(let detail):
                        seal.fulfill(detail)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func fetchRepositories(for username: String) -> Promise<[Repository]> {
        return Promise { seal in
            let url = "https://api.github.com/users/\(username)/repos"
            AF.request(url)
                .validate()
                .responseDecodable(of: [Repository].self) { response in
                    switch response.result {
                    case .success(let repos):
                        seal.fulfill(repos)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }
}
