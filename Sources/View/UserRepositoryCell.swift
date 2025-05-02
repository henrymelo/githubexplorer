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
        container.layer.cornerRadius = LayoutConstants.avatarCornerRadius
        container.layer.masksToBounds = true

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.isUserInteractionEnabled = true

        repoLabel.font = .systemFont(ofSize: LayoutConstants.defaultSpacing, weight: .medium)
        repoLabel.numberOfLines = 1
        repoLabel.isUserInteractionEnabled = true

        contentView.addSubview(container)
        container.addSubview(avatarImageView)
        container.addSubview(repoLabel)
    }

    private func setupConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(LayoutConstants.compactSpacing)
        }

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(LayoutConstants.avatarCornerRadius)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }

        repoLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(LayoutConstants.defaultSpacing)
            make.trailing.equalToSuperview().inset(LayoutConstants.avatarCornerRadius)
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
