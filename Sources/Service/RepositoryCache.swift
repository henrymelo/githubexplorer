//
//  RepositoryCache.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation

final class RepositoryCache {
    private let cacheKey = "cached_repositories"
    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        fileURL = dir.appendingPathComponent("\(cacheKey).json")
    }

    func save(_ repositories: [Repository]) {
        do {
            let data = try JSONEncoder().encode(repositories)
            try data.write(to: fileURL)
        } catch {
            print("Erro ao salvar cache: \(error)")
        }
    }

    func load() -> [Repository] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Repository].self, from: data)
        } catch {
            print("Erro ao carregar cache: \(error)")
            return []
        }
    }
}