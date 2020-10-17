//
//  DataRouter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

//Presenter to Data
protocol DataShowRouterProtocol {
    var view: UIViewController? { get set }
    func createAddAlert()
}


class ExpenseRouter: DataShowRouterProtocol {
    
    weak var view: UIViewController?
    
    func createAddAlert() {
        let addDataView = AddDataAssembly.assemble()
        view?.navigationController?.pushViewController(addDataView, animated: true)
    }
}
