//
//  UserDetailBuilder.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

enum UserDetailBuilder {
    static func build(username: String) -> UIViewController {
        let service: GitHubServiceProtocol = GitHubService()
        let viewModel: UserDetailViewModelProtocol = UserDetailViewModel(service: service)
        let vc = UserDetailViewController(viewModel: viewModel)
        vc.username = username
        return vc
    }
}