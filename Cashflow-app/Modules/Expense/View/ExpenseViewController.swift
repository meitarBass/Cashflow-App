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
    
    private lazy var expenseChartPie: ChartPie = {
        let pie = ChartPie(frame: .zero, pulsatingColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
        return pie
    }()
    
    private lazy var savingChartPie: ChartPie = {
        let pie = ChartPie(frame: .zero, pulsatingColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1))
        return pie
    }()
    
    private lazy var pieStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [expenseChartPie, savingChartPie])
        stack.distribution = .fillEqually
        stack.spacing = 8.0
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var viewStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [pieStack, dataTable])
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.axis = .vertical
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
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
//        self.view.addSubview(dataTable)
//        self.view.addSubview(pieStack)
        self.view.addSubview(viewStack)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        viewStack.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
        }
        
//        dataTable.snp.makeConstraints { (make) in
//            make.bottom.leading.trailing.equalToSuperview()
//            make.height.equalTo(200)
//        }
//
//        pieStack.snp.makeConstraints { (make) in
//            make.bottom.equalTo(dataTable.snp.topMargin).offset(-36)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(140)
//        }
        
        expenseChartPie.snp.makeConstraints { (make) in
            make.width.equalTo(140)
        }

        savingChartPie.snp.makeConstraints { (make) in
            make.width.equalTo(140)
        }

    }
}

extension ExpenseViewController {
    @objc private func addNewData() {
        self.presenter?.addNewData()
    }
}

extension ExpenseViewController: ExpenseViewInput {
    func gotDataSuccess(expenses: ([categories : Int]?, Int),
                        savings: ([categories : Int]?, Int)) {
        guard let expensesDict = expenses.0, let savingsDict = savings.0 else { return }
        expenseChartPie.setupUI(expenses: expensesDict, total: CGFloat(expenses.1))
        savingChartPie.setupUI(expenses: savingsDict, total: CGFloat(savings.1))
    }
    
    func refresh() {
        if let expenseLayers = expenseChartPie.layer.sublayers {
            for layer in expenseLayers {
                layer.removeFromSuperlayer()
            }
        }
        
        if let savingLayers = savingChartPie.layer.sublayers {
            for layer in savingLayers {
                layer.removeFromSuperlayer()
            }
        }
        presenter?.viewDidLoad()
    }
}
