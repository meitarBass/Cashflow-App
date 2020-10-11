//
//  DataViewController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

class DataViewController: UIViewController {
    
    private lazy var lineGraph: LineGraph = {
        let graph = LineGraph()
        return graph
    }()
    
    override func viewDidLoad() {
        print("Got here")
        view.backgroundColor = .white
    }
    
    func setUpUi() {
        
    }
    
    func makeConstraints() {
        
    }
}
