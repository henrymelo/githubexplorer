//
//  UserDetailViewController.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import AlamofireImage
import UIKit
import SnapKit


private let avatarImageView = UIImageView()
private let locationLabel = UILabel()

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let errorView = ErrorStateView()
    var username: String?
    var viewModel: UserDetailViewModelProtocol

    private let tableView = UITableView()
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init(viewModel: UserDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    private func showErrorState(message: String, retryHandler: @escaping () -> Void) {
        errorView.configure(type: .network, message: message)
        errorView.onRetry = retryHandler
        if errorView.superview == nil {
            view.addSubview(errorView)
        }
        errorView.isHidden = false
        view.bringSubviewToFront(errorView)
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func hideErrorState() {
        errorView.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalhes"
        setupUI()
        bindViewModel()
        loadUserDetails()
    }

    private func setupUI() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoCell")
        tableView.dataSource = self
        tableView.delegate = self

        let stack = UIStackView(arrangedSubviews: [nameLabel, bioLabel, followersLabel, followingLabel, tableView])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onRepositoriesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.hideErrorState()
                self?.tableView.reloadData()
            }
        }
    }

    private func loadUserDetails() {
        guard let username = username else { return }

        activityIndicator.startAnimating()

        activityIndicator.startAnimating()
        viewModel.fetchUserDetail(username: username)
            .then { self.viewModel.fetchRepositories(for: username) }
            .done {
                if let detail = self.viewModel.userDetail {
                    self.nameLabel.text = "Nome: \(detail.name ?? "-")"
                    self.bioLabel.text = "Bio: \(detail.bio ?? "-")"
                    self.followersLabel.text = "Seguidores: \(detail.followers)"
                    self.followingLabel.text = "Seguindo: \(detail.following)"
                }
                self.tableView.reloadData()
            }
            .catch { error in
                self.activityIndicator.stopAnimating()
                self.showErrorState(message: "Não foi possível carregar os detalhes dos dados do usuário selecionado. Por favor, Tente novamente mais tarde.") {
                    self.loadUserDetails()
                }
            }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.repositories.count - 1, viewModel.hasMoreRepos {
            viewModel.fetchRepositories(for: viewModel.userDetail?.login ?? "")
        }
    }
}
