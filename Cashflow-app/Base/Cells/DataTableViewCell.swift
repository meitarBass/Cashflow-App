//
//  DataTableViewCell.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit
import SnapKit

struct DataCellViewModel {
    let data: DataModel?
}

class DataTableViewCell: UITableViewCell {
    
    var viewModel: DataCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.data?.date
            categoryLabel.text = viewModel.data?.category
            amountLabel.text = viewModel.data?.amount
        }
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .bold12
        label.textColor = .dataViewLabels
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .bold20
        label.textColor = .dataViewLabels
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .bold15
        label.textColor = .dataViewLabels
        return label
    }()
    
    private let appearance = Appearance()
    
    private lazy var amountCategoryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryLabel, dateLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(amountCategoryStack)
        self.addSubview(amountLabel)
    }
    
    private func makeConstraints() {
        amountCategoryStack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
        }
        
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    func addGradientBackground() {
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        guard let category = categories(rawValue: viewModel?.data?.category ?? "") else { return }
        let colors = category.getColors(category: category)
        gradientLayer.colors = [colors.0.cgColor, colors.1.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
