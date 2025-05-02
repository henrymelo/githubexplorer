//
//  UserListBuilder.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

enum UserListBuilder {
    static func build() -> UIViewController {
        let service: GitHubServiceProtocol = GitHubService()
        let viewModel: UserListViewModelProtocol = UserListViewModel(service: service)
        return UserListViewController(viewModel: viewModel)
    }
}
