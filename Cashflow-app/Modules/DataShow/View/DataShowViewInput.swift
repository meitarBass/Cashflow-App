//
//  DataViewInput.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

// Presenter to View
protocol DataShowViewInput: class {
    func gotDataSuccess(expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int))
    func refresh()
}
