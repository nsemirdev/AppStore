//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Emir Alkal on 25.02.2023.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupViewControllers()
    }
    
    private func setupAppearance() {
        let navAppearance = UITabBarAppearance()
        navAppearance.configureWithDefaultBackground()
        
        UITabBar.appearance().standardAppearance = navAppearance
        UITabBar.appearance().scrollEdgeAppearance = navAppearance
        
        let tabAppearance = UINavigationBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        
        UINavigationBar.appearance().standardAppearance = tabAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = tabAppearance
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    
    private func setupViewControllers() {
        let todayNav = createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon")
        let appsNav = createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps")
        let searchNav = createNavController(viewController: SearchViewController(), title: "Search", imageName: "search")
        
        viewControllers = [todayNav, appsNav,searchNav]
    }
    
    private func createNavController(
        viewController: UIViewController,
        title: String,
        imageName: String) -> UIViewController {
        
            viewController.view.backgroundColor = .white
            viewController.navigationItem.title = title
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = UIImage(named: imageName)
            return navController
    }
}

