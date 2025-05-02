//
//  UserListViewController.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import SkeletonView
import UIKit
import SnapKit
import SnapKit
import PromiseKit

class UserListViewController: UIViewController {
    private let errorView = ErrorStateView()
    final private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "GitHub\nExplorer"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Nenhum usuário encontrado"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: LayoutConstants.defaultSpacing)
        label.isHidden = true
        return label
    }()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = AppStrings.loadingMessage
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: LayoutConstants.defaultSpacing)
        return label
    }()

    var viewModel: UserListViewModelProtocol
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let loading = UIActivityIndicatorView(style: .large)

    init(viewModel: UserListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showErrorState(message: String, retryHandler: @escaping () -> Void) {
        errorView.configure(type: .network, message: message)
        errorView.onRetry = retryHandler
        view.addSubview(errorView)
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
        view.addSubview(appNameLabel)
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)

        SkeletonAppearance.default.multilineCornerRadius = Int(LayoutConstants.compactSpacing)
        SkeletonAppearance.default.tintColor = UIColor.lightGray.withAlphaComponent(0.2)
        SkeletonAppearance.default.gradient = SkeletonGradient(baseColor: UIColor.lightGray.withAlphaComponent(0.2))
        title = "GitHubExplorer"
        view.backgroundColor = .systemBackground

        view.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        view.addSubview(emptyLabel)
        emptyLabel.frame = view.bounds
        view.addSubview(loading)
        loading.center = view.center
        loading.hidesWhenStopped = true

        viewModel.loadCachedUsers()
        setupUI()
        bindViewModel()
        fetchUsers()
    }

    private func setupUI() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        loading.hidesWhenStopped = true

        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(loading)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func bindViewModel() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.loading.stopAnimating()
            self?.hideErrorState()
                self?.loading.stopAnimating()
                self?.hideErrorState()
                self?.tableView.reloadData()
            self?.emptyLabel.isHidden = !(self?.viewModel.users.isEmpty ?? true)
        }
    }

    private func fetchUsers() {
        loading.startAnimating()
        viewModel.fetchUsers().catch { error in
            self.showErrorState(message: "Não foi possível carregar a lista de usuários do GitHub. Verifique a conexão ou tente novamente mais tarde.") {
                self.fetchUsers()
            }
            self.loading.stopAnimating()
        }
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        loading.startAnimating()
        viewModel.searchUsers(query: query)
    }
}
