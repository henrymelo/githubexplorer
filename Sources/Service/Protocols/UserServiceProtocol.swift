//
//  UserServiceProtocol.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import PromiseKit

protocol UserServiceProtocol {
    func fetchUsers(since: Int?) -> Promise<[User]>
    func searchUsers(query: String) -> Promise<[User]>
}