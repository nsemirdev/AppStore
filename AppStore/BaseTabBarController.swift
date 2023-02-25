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
        let redVC = UIViewController()
        redVC.view.backgroundColor = .white
        redVC.navigationItem.title = "Today"
        
        let blueVC = UIViewController()
        blueVC.view.backgroundColor = .white
        blueVC.navigationItem.title = "Apps"
        
        let greenVC = UIViewController()
        greenVC.view.backgroundColor = .white
        greenVC.navigationItem.title = "Search"
        
        let redNav = UINavigationController(rootViewController: redVC)
        let blueNav = UINavigationController(rootViewController: blueVC)
        let greenNav = UINavigationController(rootViewController: greenVC)
        
        redNav.tabBarItem.title = "Today"
        redNav.tabBarItem.image = UIImage(named: "today_icon")
        
        blueNav.tabBarItem.title = "Apps"
        blueNav.tabBarItem.image = UIImage(named: "apps")
        
        greenNav.tabBarItem.title = "Search"
        greenNav.tabBarItem.image = UIImage(named: "search")
    
        viewControllers = [
            redNav,
            blueNav,
            greenNav
        ]
    }
}

