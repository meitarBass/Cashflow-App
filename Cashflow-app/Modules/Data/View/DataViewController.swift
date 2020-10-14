//
//  DataViewController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit
import SnapKit

class DataViewController: UIViewController {
    
    private lazy var lineGraph: LineGraph = {
        let graph = LineGraph(frame: .zero)
        graph.backgroundColor = .blue
        return graph
    }()
    
    private lazy var chartPie: ChartPie = {
        let pie = ChartPie(frame: .zero, fromColor: #colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), toColor: #colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1), pulsatingColor: #colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1), data: 76)
        return pie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
    }
    
    func setUpUi() {
        self.addSubviews()
        self.makeConstraints()
        
        self.view.backgroundColor = .white
    }
    
    func addSubviews() {
//        self.view.addSubview(lineGraph)
        self.view.addSubview(chartPie)
    }
    
    func makeConstraints() {
//        lineGraph.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.height.width.equalTo(250)
//        }
        
        chartPie.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
}
