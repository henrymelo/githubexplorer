//
//  ErrorStateView.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit
import SnapKit

enum ErrorType {
    case network
    case empty
    case unauthorized
    case unknown

    var emoji: String {
        switch self {
        case .network: return "⚠️"
        case .empty: return "📭"
        case .unauthorized: return "🔒"
        case .unknown: return "❗️"
        }
    }

    var defaultMessage: String {
        switch self {
        case .network:
            return "Não foi possível carregar a lista. Verifique sua conexão e tente novamente mais tarde."
        case .empty:
            return "Nenhum conteúdo encontrado."
        case .unauthorized:
            return "Você não tem permissão para acessar este conteúdo."
        case .unknown:
            return "Não foi possível completar a ação. Por favor, tente novamente mais tarde."
        }
    }
}

final class ErrorStateView: UIView {
    private let emojiLabel = UILabel()
    private let messageLabel = UILabel()
    private let retryButton = UIButton(type: .system)

    var onRetry: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(type: ErrorType, message: String? = nil) {
        emojiLabel.text = type.emoji
        messageLabel.text = message ?? type.defaultMessage
    }

    private func setup() {
        backgroundColor = .systemBackground

        emojiLabel.font = UIFont.systemFont(ofSize: 72)
        emojiLabel.textAlignment = .center

        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 16)

        retryButton.setTitle("Tentar novamente", for: .normal)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)

        addSubview(emojiLabel)
        addSubview(messageLabel)
        addSubview(retryButton)

        emojiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
        }

        retryButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }

    @objc private func retryTapped() {
        onRetry?()
    }
}
