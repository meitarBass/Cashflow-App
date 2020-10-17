//
//  DataPresenterProtocols.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

// View to Presenter
protocol DataShowPresenterProtocol: class {
    func viewDidLoad()
    func addNewData()
    var tableViewManager: DataShowTableViewManagerProtocol? { get set }
}


// Interactor to Presenter
protocol DataShowPresenterInput: class {
    func gotDataSuccess(data: [DataModel],
                        expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int))
}

// Manager to Presenter
protocol DataShowTableViewManagerDelegate: class {
    func deleteRowData(row: Int)
}
