//
//  UserDetailViewModelProtocol.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import PromiseKit

protocol UserDetailViewModelProtocol {
    var hasMoreRepos: Bool { get }
    var userDetail: UserDetail? { get }
    var repositories: [Repository] { get }
    var onRepositoriesUpdated: (() -> Void)? { get set }

    func fetchUserDetail(username: String) -> Promise<Void>
    func fetchRepositories(for username: String) -> Promise<Void>
}
