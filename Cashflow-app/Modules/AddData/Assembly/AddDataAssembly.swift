//
//  AddDataAssembly.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

class AddDataAssembly {
    static func assemble() -> UIViewController {
        let view = AddDataViewController()
        let presenter = addDataPresenter()
        let interactor = AddDataInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}
