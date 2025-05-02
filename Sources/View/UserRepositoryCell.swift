//
//  UserRepositoryCell.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit
import SnapKit

final class UserRepositoryCell: UITableViewCell {
    static let identifier = "UserRepositoryCell"

    let avatarImageView = UIImageView()
    let repoLabel = UILabel()
    let container = UIView()
    
    var onAvatarTap: (() -> Void)?
    var onRepoTap: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12
        container.layer.masksToBounds = true

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.isUserInteractionEnabled = true

        repoLabel.font = .systemFont(ofSize: 16, weight: .medium)
        repoLabel.numberOfLines = 1
        repoLabel.isUserInteractionEnabled = true

        contentView.addSubview(container)
        container.addSubview(avatarImageView)
        container.addSubview(repoLabel)
    }

    private func setupConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }

        repoLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }

    private func setupGestures() {
        let avatarTap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.addGestureRecognizer(avatarTap)

        let repoTap = UITapGestureRecognizer(target: self, action: #selector(repoTapped))
        repoLabel.addGestureRecognizer(repoTap)
    }

    @objc private func avatarTapped() {
        onAvatarTap?()
    }

    @objc private func repoTapped() {
        onRepoTap?()
    }
}
