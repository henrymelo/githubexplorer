//
//  Repository.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let name: String
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let updatedAt: String
    let isPrivate: Bool
    let isArchived: Bool
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case updatedAt = "updated_at"
        case isPrivate = "private"
        case isArchived = "archived"
        case htmlUrl = "html_url"
    }
}
