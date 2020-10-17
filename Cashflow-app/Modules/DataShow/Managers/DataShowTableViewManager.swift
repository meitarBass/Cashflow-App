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

protocol DataShowTableViewManagerProtocol {
    func setUpTableView(tableView: UITableView)
    func setUpCells(data: [DataModel])
}

class DataShowTableViewManager: NSObject {

    weak var tableView: UITableView?
    weak var delegate: DataShowTableViewManagerDelegate?
    
    var cashFlow: [DataModel]?
    
    let appearance = Appearance()
}

extension DataShowTableViewManager: DataShowTableViewManagerProtocol {
    
    func setUpTableView(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .buttonColor
        self.tableView?.register(DataTableViewCell.self, forCellReuseIdentifier: DataTableViewCell.identifier)
    }
    
    func setUpCells(data: [DataModel]) {
        self.cashFlow = data
        self.tableView?.reloadData()
    }
}

extension DataShowTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return appearance.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DataShowTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cashFlow?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier, for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = DataCellViewModel(data: cashFlow?[indexPath.row])
        cell.viewModel = cellViewModel
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let transaction = self.cashFlow else { return }
        let data = DataModelRealm()
        data.amount = transaction[indexPath.row].amount
        data.category = transaction[indexPath.row].category
        data.date = transaction[indexPath.row].date
        
        if editingStyle == .delete {
            delegate?.deleteRowData(row: indexPath.row)
        }
    }
}

