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
        let graphsViewController = GraphsViewController()
        graphsViewController.tabBarItem = UITabBarItem(title: "Graphs", image: UIImage(systemName: "bandage"), selectedImage:  UIImage(systemName: "bandage"))
        return UINavigationController(rootViewController: graphsViewController)
    }
    
    private func createExpenseVC() -> UINavigationController {
        let expenseViewController = ExpenseAssembly.assemble()
        expenseViewController.tabBarItem = UITabBarItem(title: "Expense", image: UIImage(systemName: "scale.3d"), selectedImage:  UIImage(systemName: "scale.3d"))
        return UINavigationController(rootViewController: expenseViewController)
    }
        
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .buttonColor
        //add more tabs here
        tabBar.viewControllers = [createExpenseVC()]
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

