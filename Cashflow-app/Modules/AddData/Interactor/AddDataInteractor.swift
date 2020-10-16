//
//  AddDataInteractor.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

class AddDataInteractor: AddDataInteractorInput {
    
    var realm = RealmManager()
    var presenter: addDataPresenter?
    
    func saveData(data: DataModel) {
        let modeledData = fixDataFormat(data: data)
        realm.saveData(object: modeledData, modelType: DataModelRealm.self)
        presenter?.saveDataSuccessfuly()
    }
    
    func fixDataFormat(data: DataModel) -> DataModelRealm {
        let modeledData = DataModelRealm()
        modeledData.amount = data.amount
        modeledData.category = data.category
        modeledData.date = data.date
        return modeledData
    }
}
