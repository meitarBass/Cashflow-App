//
//  DataPresenter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

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
    func gotDataSuccess(data: [DataModel],
                        expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int)) {
        self.data = data
        self.tableViewManager?.setUpCells(data: data)
        
        self.view?.gotDataSuccess(expenses: expenses,
                                  savings: savings)
    }
}

extension ExpensePresenter: ExpensesTableViewManagerDelegate {
    func deleteRowData(row: Int) {
        interactor?.deleteData(row: row)
        interactor?.loadData()
    }
}
