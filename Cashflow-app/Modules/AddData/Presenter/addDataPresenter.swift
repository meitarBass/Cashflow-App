//
//  addDataPresenter.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

class AddDataPresenter {
    weak var view: AddDataViewController?
    
    var interactor: AddDataInteractorInput?
    var data: DataModel?
}

extension AddDataPresenter: AddDataPresenterProtocol {
    func viewDidLoad() {}
    
    func addNewData(data: DataModel) {
        interactor?.saveData(data: data)
    }
}

extension AddDataPresenter: AddDataPresenterInput {
    func saveDataSuccessfuly() {
        view?.dataAddedSuccessfuly()
    }
}
