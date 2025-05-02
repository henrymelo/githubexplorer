//
//  RepositoryDetailViewController.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var repository: Repository?

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositório"
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Ver no GitHub",
            style: .plain,
            target: self,
            action: #selector(openInGitHub)
        )

        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoDetailCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoDetailCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        guard let repo = repository else {
            content.text = "Dados indisponíveis"
            cell.contentConfiguration = content
            return cell
        }

        var text = ""
        switch indexPath.row {
        case 0:
            text = "📘 \(repo.name)"
        case 1:
            text = "📝 \(repo.description ?? "Sem descrição")"
        case 2:
            text = "🧬 Linguagem: \(repo.language ?? "N/A")"
        case 3:
            text = "⭐ \(repo.stargazersCount)   🍴 \(repo.forksCount)   ❗ \(repo.openIssuesCount)"
        case 4:
            let isoFormatter = ISO8601DateFormatter()
            let formatter = DateFormatter.brazilianShort
            if let date = isoFormatter.date(from: repo.updatedAt) {
                text = "🕓 Atualizado em: \(formatter.string(from: date))"
            } else {
                text = "🕓 Data inválida"
            }
        case 5:
            let status = repo.isPrivate ? "🔒 Privado" : "🔓 Público"
            text = repo.isArchived ? "📦 Arquivado" : status
        default:
            text = ""
        }

        content.text = text
        content.textProperties.numberOfLines = 2
        cell.contentConfiguration = content
        cell.accessibilityLabel = text
        cell.accessibilityTraits = .staticText

        return cell
    }

    @objc func openInGitHub() {
        guard let urlString = repository?.htmlUrl, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
