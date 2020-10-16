//
//  DataTableViewManager.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

struct Appearance {
    let rowHeight: CGFloat = 72.0
}

protocol ExpenseTableViewManagerProtocol {
    func setUpTableView(tableView: UITableView)
    func setUpCells(data: [DataModel])
}

class ExpenseTableViewManager: NSObject {

    weak var tableView: UITableView?
    weak var delegate: ExpensesTableViewManagerDelegate?
    
    var cashFlow: [DataModel]?
    
    let appearance = Appearance()
}

extension ExpenseTableViewManager: ExpenseTableViewManagerProtocol {
    
    func setUpTableView(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(DataTableViewCell.self, forCellReuseIdentifier: DataTableViewCell.identifier)
    }
    
    func setUpCells(data: [DataModel]) {
        self.cashFlow = data
        self.tableView?.reloadData()
    }
}

extension ExpenseTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return appearance.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ExpenseTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cashFlow?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier, for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = DataCellViewModel(data: cashFlow?[indexPath.row])
        cell.viewModel = cellViewModel
        return cell
    }
}

