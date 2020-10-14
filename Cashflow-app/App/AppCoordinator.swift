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
    
    private func createGraphsVC() -> UINavigationController {
//        let discoverViewController = DiscoverAssembly.assemble(endpoint: .getTopHeadlines)
        let graphsViewController = GraphsViewController()
        graphsViewController.tabBarItem = UITabBarItem(title: "Graphs", image: UIImage(systemName: "bandage"), selectedImage:  UIImage(systemName: "bandage"))
        return UINavigationController(rootViewController: graphsViewController)
    }
    
    private func createDataVC() -> UINavigationController {
//        let discoverViewController = DiscoverAssembly.assemble(endpoint: .getTopHeadlines)
        let dataViewController = DataViewController()
        dataViewController.tabBarItem = UITabBarItem(title: "Data", image: UIImage(systemName: "scale.3d"), selectedImage:  UIImage(systemName: "scale.3d"))
        return UINavigationController(rootViewController: dataViewController)
    }
    
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.blue
        //add more tabs here
        tabBar.viewControllers = [createDataVC(), createGraphsVC()]
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

