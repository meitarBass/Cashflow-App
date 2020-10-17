//
//  DataPresenterProtocols.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation
import RealmSwift

// View to Presenter
protocol ExpensePresenterProtocol: class {
    func viewDidLoad()
    func addNewData()
    var tableViewManager: ExpenseTableViewManagerProtocol? { get set }
}


// Interactor to Presenter
protocol ExpensePresenterInput: class {
    func gotDataSuccess(data: [DataModel],
                        expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int))
}

// Manager to Presenter
protocol ExpensesTableViewManagerDelegate: class {
    func deleteRowData(row: Int)
}
