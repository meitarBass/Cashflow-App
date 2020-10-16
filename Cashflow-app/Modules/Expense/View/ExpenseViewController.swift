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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        view.backgroundColor = .black
        presenter?.viewDidLoad()
    }
    
    override func setUpUI() {
        self.addSubviews()
        self.makeConstraints()
        presenter?.viewDidLoad()
        self.presenter?.tableViewManager?.setUpTableView(tableView: dataTable)
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func addSubviews() {
        self.view.addSubview(dataTable)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        dataTable.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
    }
}

extension ExpenseViewController {
    @objc private func addNewData() {
        self.presenter?.addNewData()
    }
}

extension ExpenseViewController: ExpenseViewInput {
    
}
