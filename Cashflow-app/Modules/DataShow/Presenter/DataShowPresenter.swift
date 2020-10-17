//
//  DataPresenter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

class DataShowPresenter {
    
    weak var view: DataShowViewInput?
    var interactor: DataShowInteractorInput?
    var router: DataShowRouterProtocol?
    var tableViewManager: DataShowTableViewManagerProtocol?
}

// View to Presenter
extension DataShowPresenter: DataShowPresenterProtocol {
    func viewDidLoad() {
        interactor?.loadData()
    }
    func addNewData() {
        router?.createAddAlert()
    }
}

// Interactor to Presenter
extension DataShowPresenter: DataShowPresenterInput {
    func gotDataSuccess(data: [DataModel],
                        expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int)) {
        self.tableViewManager?.setUpCells(data: data)
        self.view?.gotDataSuccess(expenses: expenses,
                                  savings: savings)
    }
}

extension DataShowPresenter: DataShowTableViewManagerDelegate {
    func deleteRowData(row: Int) {
        interactor?.deleteData(row: row)
        view?.refresh()
    }
}
