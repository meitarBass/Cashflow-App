//
//  Categories.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 16/10/2020.
//

import Foundation

struct Categories {
    static let categoriesArr: [categories] = [.housing, .saving, .food, .transportation, .insurance, .debt, .entertainment, .medical, .giving, .shopping]
}

enum categories: String {
    case housing = "Housing"
    case saving = "Saving"
    case food = "Food"
    case transportation = "Transportation"
    case insurance = "Insurance"
    case debt = "Debt"
    case entertainment = "Entertainment"
    case medical = "Medical"
    case giving = "Giving"
    case shopping = "Shopping"
}
