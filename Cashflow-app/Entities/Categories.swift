//
//  Categories.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 16/10/2020.
//

import UIKit

struct Categories {
    static let expenseCategories: [categories] = [.housing, .saving, .food, .transportation, .insurance, .debt, .entertainment, .medical, .giving, .shopping]
    
    static let savingCategories: [categories] = [.salary, .sale, .other]
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
    
    case salary = "Salary"
    case sale = "Sale"
    case other = "Other"
    
    case expenses = "expenses"
    case savingsCategory = "savings"
    
    func getColors(category: categories) -> (UIColor, UIColor) {
        switch category {
        case .housing:
            return UIColor.gradientHousing
        case .saving:
            return UIColor.gradientSavings
        case .food:
            return UIColor.gradientFood
        case .transportation:
            return UIColor.gradientTransportation
        case .insurance:
            return UIColor.gradientInsurance
        case .debt:
            return UIColor.gradientDebt
        case .entertainment:
            return UIColor.gradientEntertainment
        case .medical:
            return UIColor.gradientMedical
        case .giving:
            return UIColor.gradientGiving
        case .shopping:
            return UIColor.gradientShopping
            
        case .salary:
            return UIColor.gradientSalary
        case .sale:
            return UIColor.gradientSale
        case .other:
            return UIColor.gradientOther
            
            
        case .expenses:
            return UIColor.gradientExpenses
        case .savingsCategory:
            return UIColor.gradientSavingsCategory
        }
    }
}
