//
//  UserDetail.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation

struct UserDetail: Codable {
    let login: String
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
    let publicRepos: Int
    let company: String?
    let location: String?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case login
        case name
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
        case company
        case location
        case avatarUrl = "avatar_url"
    }
}
