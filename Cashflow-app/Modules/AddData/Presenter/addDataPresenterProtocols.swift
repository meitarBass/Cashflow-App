//
//  addDataPresenterProtocols.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

// View to Presenter
protocol AddDataPresenterProtocol: class {
    func viewDidLoad()
    func addNewData(data: DataModel)
}


// Interactor to Presenter
protocol AddDataPresenterInput: class {
    func saveDataSuccessfuly()
}

//
protocol AddDataTableViewManagerDelegate: class {}
