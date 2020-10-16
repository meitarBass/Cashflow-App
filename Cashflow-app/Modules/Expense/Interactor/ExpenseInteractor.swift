//
//  DataInteractor.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation

final class ExpenseInteractor: ExpenseInteractorInput {

    weak var presenter: ExpensePresenterInput?
    var realmManager: RealmManagerProtocol?
    
    func loadData() {
        var data = [DataModel]()
        let savedData = realmManager?.loadData(modelType: DataModelRealm.self)
        for index in 0..<(savedData?.count ?? 0){
            let item = savedData?[index]
            data.append(DataModel(date: item?.date, amount: item?.amount, category: item?.category))
        }
        presenter?.gotDataSuccess(data: data)
    }

}
