//
//  DataViewController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit
import SnapKit

class GraphsViewController: BaseViewController {
    
    private lazy var dataTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "AmericanTypewriter", size: 28)
        label.text = "Expenses Monthly"
        return label
    }()
    
    private lazy var timeButton: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    private lazy var typeButton: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    private lazy var chartPie: ChartPie = {
        let pie = ChartPie(frame: .zero, pulsatingColor: #colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1))
        return pie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func setUpUI() {
        self.addSubviews()
        self.makeConstraints()
        
        self.view.backgroundColor = .white
    }
    
    override func addSubviews() {
//        self.view.addSubview(lineGraph)
        self.view.addSubview(chartPie)
        self.view.addSubview(dataTitle)
    }
    
    override func makeConstraints() {
//        lineGraph.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.height.width.equalTo(250)
//        }
        
        chartPie.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        dataTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(24)
//            make.bottom.equalTo(chartPie.snp.top).offset(50)
        }
    }
}
