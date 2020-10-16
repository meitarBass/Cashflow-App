//
//  DataViewController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 14/10/2020.
//

import Foundation
import SnapKit

class ExpenseViewController: BaseViewController {
    
    var presenter: ExpensePresenterProtocol?
    
    var data: [DataModel]?
    
    private lazy var dataTable: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewData))
        return barButton
    }()
    
    private lazy var lineGraph: LineGraph = {
        let lineGraph = LineGraph(frame: .zero)
        return lineGraph
    }()
    
    private lazy var chartPie: ChartPie = {
        let pie = ChartPie(frame: .zero, pulsatingColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
        return pie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        presenter?.viewDidLoad()
    }
    
    override func setUpUI() {
        super.setUpUI()
        title = "My Expenses"
        self.addSubviews()
        self.makeConstraints()
        self.presenter?.tableViewManager?.setUpTableView(tableView: dataTable)
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func addSubviews() {
        self.view.addSubview(dataTable)
        self.view.addSubview(lineGraph)
        self.view.addSubview(chartPie)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        dataTable.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        chartPie.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineGraph.snp.topMargin).offset(-48)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        lineGraph.snp.makeConstraints { (make) in
            make.bottom.equalTo(dataTable.snp.topMargin).offset(-48)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(150)
        }
    }
}

extension ExpenseViewController {
    @objc private func addNewData() {
        self.presenter?.addNewData()
    }
}

extension ExpenseViewController: ExpenseViewInput {
    func getData(data: [DataModel]?) {
        guard let data = data else { return }
        self.data = data
        
        var total = 0
        var expenses: [categories : CGFloat] = [categories : CGFloat]()
        for data in data {
            let newAmount = Int(data.amount!.replacingOccurrences(of: "$", with: ""))!
            guard let category = categories(rawValue: data.category!) else { return }
            
            if expenses.keys.contains(category) {
                expenses[category]! += CGFloat(newAmount)
            } else {
                expenses[category] = CGFloat(newAmount)
            }
            total += newAmount
        }
        
        chartPie.setupUI(expenses: expenses, total: CGFloat(total))
    }
}
