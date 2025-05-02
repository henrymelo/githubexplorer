//
//  RepositoryCell.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit
import SnapKit

final class RepositoryCell: UITableViewCell {
    static let identifier = "RepositoryCell"

    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let statsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        languageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        languageLabel.adjustsFontForContentSizeCategory = true
        languageLabel.textColor = .systemBlue
        statsLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        statsLabel.adjustsFontForContentSizeCategory = true
        statsLabel.textAlignment = .right
        statsLabel.textColor = .secondaryLabel

        let bottomStack = UIStackView(arrangedSubviews: [languageLabel, statsLabel])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalSpacing

        let stack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, bottomStack])
        stack.axis = .vertical
        stack.spacing = 6

        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(LayoutConstants.avatarCornerRadius)
        }
    }

    func configure(with repo: Repository) {
        nameLabel.text = "💻 " + repo.name
        descriptionLabel.text = repo.description ?? "Sem descrição"
        languageLabel.text = "🧬 " + (repo.language ?? "N/A")
        statsLabel.text = "⭐️ \(repo.stargazersCount)   🍴 \(repo.forksCount)   ❗️ \(repo.openIssuesCount)"
    }
}
