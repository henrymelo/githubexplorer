//
//  UserListViewModelProtocol.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import PromiseKit

protocol UserListViewModelProtocol {
    var hasMoreData: Bool { get }
    var users: [User] { get }
    var onUsersUpdated: (() -> Void)? { get set }

    func fetchUsers() -> Promise<Void>
    func searchUsers(query: String)
    func loadCachedUsers()
}
