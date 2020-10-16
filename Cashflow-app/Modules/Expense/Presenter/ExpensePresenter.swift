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

extension ExpensePresenter: ExpensePresenterProtocol {
    func viewDidLoad() {
        interactor?.loadData()
    }
    func addNewData() {
        router?.createAddAlert()
    }
}

extension ExpensePresenter: ExpensePresenterInput {
    func gotDataSuccess(data: [DataModel]) {
        self.data = data
        self.tableViewManager?.setUpCells(data: data)
    }
}

extension ExpensePresenter: ExpensesTableViewManagerDelegate {}
