//
//  User.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}
