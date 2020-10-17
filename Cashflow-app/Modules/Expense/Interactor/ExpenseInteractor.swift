//
//  DataInteractor.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation
import RealmSwift

final class ExpenseInteractor: ExpenseInteractorInput {

    weak var presenter: ExpensePresenterInput?
    var realmManager: RealmManagerProtocol?
    var realmData: Results<DataModelRealm>?
    
    func loadData() {
        var data = [DataModel]()
        let savedData = realmManager?.loadData(modelType: DataModelRealm.self)
        realmData = savedData
        for index in 0..<(savedData?.count ?? 0){
            let item = savedData?[index]
            data.append(DataModel(date: item?.date, amount: item?.amount, category: item?.category))
        }
        
        presenter?.gotDataSuccess(data: data,
                                  expenses: createExpenses(data: data),
                                  savings: createSavings(data: data))
    }
    
    func deleteData(row: Int) {
        guard let data = realmData else { return }
        realmManager?.deleteData(object: data[row], modelType: DataModelRealm.self)
    }
    
    private func createExpenses(data: [DataModel]) -> ([categories : Int]?, Int) {
        var expenses: [categories : Int] = [categories : Int]()
        var totalExpenses = 0
        for item in data {
            guard let amountString = item.amount, let categoryString = item.category
            else { return (expenses, totalExpenses) }
            
            guard let amount = Int(amountString.replacingOccurrences(of: "$", with: "")),
                  let category = categories(rawValue: categoryString)
            else { return (expenses, totalExpenses) }
            
            if amount < 0 {
                if let oldAmount = expenses[category] {
                    expenses.updateValue(oldAmount + amount, forKey: category)
                } else {
                    expenses[category] = amount
                }
                totalExpenses += amount
            }
        }
        return (expenses, totalExpenses)
    }
    
    private func createSavings(data: [DataModel]) -> ([categories : Int]?, Int) {
        var savings: [categories : Int] = [categories : Int]()
        var totalSavings = 0
        for item in data {
            guard let amountString = item.amount, let categoryString = item.category
            else { return (savings, totalSavings) }
            
            guard let amount = Int(amountString.replacingOccurrences(of: "$", with: "")),
                  let category = categories(rawValue: categoryString)
            else { return (savings, totalSavings) }
            
            if amount >= 0 {
                if let oldAmount = savings[category] {
                    savings.updateValue(oldAmount + amount, forKey: category)
                } else {
                    savings[category] = amount
                }
                totalSavings += amount
            }
        }
        return (savings, totalSavings)
    }
}
