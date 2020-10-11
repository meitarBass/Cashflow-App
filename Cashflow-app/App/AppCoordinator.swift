//
//  AppCoordinator.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit


protocol AppCoordinatorProtocol: class {
    func createHomePage(scene: UIWindowScene)
}

class AppCoordinator {
    var window: UIWindow?
}

// MARK: Home page case
extension AppCoordinator {
    private func createDataVC() -> UINavigationController {
//        let discoverViewController = DiscoverAssembly.assemble(endpoint: .getTopHeadlines)
//        discoverViewController.title = "Discover"
//        discoverViewController.tabBarItem = UITabBarItem(title: "Discover", image: UIImage.tabBarItems.discover, selectedImage:  UIImage.tabBarItems.discover)
//
        
        let dataViewController = DataViewController()
        
        return UINavigationController(rootViewController: dataViewController)
    }
    
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.blue
        //add more tabs here
        tabBar.viewControllers = [createDataVC()]
        return tabBar
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    

    func createHomePage(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
    }
}

