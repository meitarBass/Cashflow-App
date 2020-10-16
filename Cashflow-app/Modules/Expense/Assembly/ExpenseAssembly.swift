//
//  DataAssembly.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

class ExpenseAssembly {
    static func assemble() -> UIViewController {
        let view = ExpenseViewController()
        let tableViewManager = ExpenseTableViewManager()
        let presenter = ExpensePresenter()
        let interactor = ExpenseInteractor()
        let router = ExpenseRouter()
        
        view.presenter = presenter
        
        tableViewManager.delegate = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.tableViewManager = tableViewManager
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.realmManager = RealmManager()
        
        router.view = view
        
        return view
    }
}

