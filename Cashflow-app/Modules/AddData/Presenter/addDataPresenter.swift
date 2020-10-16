//
//  addDataPresenter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

class addDataPresenter {
    weak var view: AddDataViewController?
    
    var interactor: AddDataInteractorInput?
    var data: DataModel?
}

extension addDataPresenter: AddDataPresenterProtocol {
    func viewDidLoad() {}
    
    func addNewData(data: DataModel) {
        interactor?.saveData(data: data)
    }
}

extension addDataPresenter: AddDataPresenterInput {
    func saveDataSuccessfuly() {
        print("Data Added")
    }
}
