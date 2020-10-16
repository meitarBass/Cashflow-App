//
//  DataPresenter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

class ExpensePresenter {
    
    weak var view: ExpenseViewInput?
    var interactor: ExpenseInteractorInput?
    var router: ExpenseRouterProtocol?
    var tableViewManager: ExpenseTableViewManagerProtocol?
    var data: [DataModel]?
    
}

// View to Presenter
extension ExpensePresenter: ExpensePresenterProtocol {
    func viewDidLoad() {
        interactor?.loadData()
    }
    func addNewData() {
        router?.createAddAlert()
    }
}

// Interactor to Presenter
extension ExpensePresenter: ExpensePresenterInput {
    func gotDataSuccess(data: [DataModel]) {
        self.data = data
        self.tableViewManager?.setUpCells(data: data)
        view?.getData(data: data)
    }
}

extension ExpensePresenter: ExpensesTableViewManagerDelegate {}
