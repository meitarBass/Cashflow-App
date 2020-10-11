//
//  AppInteractor.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

class AppInteractor {
    
    private var coordinator: AppCoordinatorProtocol?
    private weak var windowScene: UIWindowScene!
    
    
    init(windowScene: UIWindowScene) {
        self.windowScene = windowScene
        self.coordinator = AppCoordinator()
        self.setScreen(scene: windowScene)
    }
    
     func setScreen(scene: UIWindowScene) {
        coordinator?.createHomePage(scene: windowScene)
    }
    
}



