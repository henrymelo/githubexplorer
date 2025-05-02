//
//  AppDelegate.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: UserListBuilder.build())
        window?.makeKeyAndVisible()

        if CommandLine.arguments.contains("-uiTestPagination") {
            let mockService = MockGitHubServiceForUITests()
            let viewModel = UserListViewModel(service: mockService)
            let controller = UserListViewController(viewModel: viewModel)
            window?.rootViewController = UINavigationController(rootViewController: controller)
            
        if UIApplication.shared.supportsAlternateIcons {
            let month = Calendar.current.component(.month, from: Date())
            let iconName: String?

            switch month {
            case 3...5: iconName = "SpringIcon"
            case 6...8: iconName = "SummerIcon"
            case 9...11: iconName = "AutumnIcon"
            default: iconName = "WinterIcon"
            }

            if UIApplication.shared.alternateIconName != iconName {
                UIApplication.shared.setAlternateIconName(iconName) { error in
                    if let error = error {
                        print("Erro ao trocar ícone: \(error.localizedDescription)")
                    }
                }
            }
        }

        LocationService.shared.requestLocationAndApplySeasonIcon()
        return true
        }
        
        if UIApplication.shared.supportsAlternateIcons {
            let month = Calendar.current.component(.month, from: Date())
            let iconName: String?

            switch month {
            case 3...5: iconName = "SpringIcon"
            case 6...8: iconName = "SummerIcon"
            case 9...11: iconName = "AutumnIcon"
            default: iconName = "WinterIcon"
            }

            if UIApplication.shared.alternateIconName != iconName {
                UIApplication.shared.setAlternateIconName(iconName) { error in
                    if let error = error {
                        print("Erro ao trocar ícone: \(error.localizedDescription)")
                    }
                }
            }
        }

        LocationService.shared.requestLocationAndApplySeasonIcon()
        return true
    }
}
