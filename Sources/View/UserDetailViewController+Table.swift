//
//  UserDetailViewController+Table.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

extension UserDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        let repo = viewModel.repositories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "📘 \(repo.name)"
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = viewModel.repositories[indexPath.row]
        let repoDetailVC = RepositoryDetailViewController()
        repoDetailVC.repository = repository
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(repoDetailVC, animated: true)
    }
}
