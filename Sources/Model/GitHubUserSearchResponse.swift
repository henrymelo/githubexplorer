//
//  GitHubUserSearchResponse.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation

struct GitHubUserSearchResponse: Decodable {
    let items: [User]
}
