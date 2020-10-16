//
//  DataModelRealm.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import Foundation
import RealmSwift

class DataModelRealm: Object {
    @objc dynamic var date: String?
    @objc dynamic var amount: String?
    @objc dynamic var category: String?
}
