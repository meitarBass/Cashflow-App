//
//  Categories.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 16/10/2020.
//

import Foundation

struct Categories {
    static let categoriesArr: [categories] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
}

enum categories: String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
}
