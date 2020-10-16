//
//  RealmManager.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 14/10/2020.
//

import UIKit
import RealmSwift

protocol RealmManagerProtocol: class {
    func saveData<T>(object: Object, modelType: T.Type)
    func loadData<T: Object>(modelType: T.Type) -> Results<T>?
    func deleteData<T>(object: Object, modelType: T.Type)
    func deleteDataFromData<T>(date: String?, modelType: T.Type) where T : Object
}

class RealmManager {
    private let realm = try! Realm()
    init() {}
}

extension RealmManager: RealmManagerProtocol {
    func saveData<T>(object: Object, modelType: T.Type) {
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            print("Error saving category \(error)")
//            self.delegate?.handleError(error: error)
        }
    }
    
    func loadData<T>(modelType: T.Type) -> Results<T>? where T : Object {
        let loadedData = realm.objects(modelType)
        return loadedData
    }
    
    func deleteData<T>(object: Object, modelType: T.Type) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
//            self.delegate?.handleError(error: error)
            print("Error deleting category \(error)")
        }
    }
    
    func deleteDataFromData<T>(date: String?, modelType: T.Type) where T : Object {
        guard let date = date else { return }
        guard let trashData = realm.objects(modelType).filter("date == %@", date).first else { return }
        self.deleteData(object: trashData, modelType: modelType)
    }
}
