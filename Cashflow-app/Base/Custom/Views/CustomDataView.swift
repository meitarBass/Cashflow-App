//
//  CustomDataView.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit
import SnapKit

class CustomDataView: UIView {
    
    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .dataViewLabels
        return label
    }()
    
    private lazy var viewMessage: UILabel = {
        let label = UILabel()
        label.font = .bold24
        label.textColor = .dataViewLabels
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [viewTitle, viewMessage])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "chevron.forward")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()

    init(frame: CGRect, title: String, message: String, color: UIColor) {
        super.init(frame: frame)
        setupUI(title: title, message: message, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, message: String, color: UIColor) {
        viewTitle.text = title
        viewMessage.text = message
        backgroundColor = color
        layer.cornerRadius = 8.0
        
        addSubviews()
        makeConstraints()
    }
    
    
    private func addSubviews() {
        self.addSubview(stackView)
        self.addSubview(arrowImage)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalTo(arrowImage).inset(8)
            make.height.equalTo(54)
        }
        
        arrowImage.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(12)
        }
    }
    
    func changeMessage(withText text: String) {
        viewMessage.text = text
    }
    
    func getValue() -> String {
        return viewMessage.text ?? ""
    }
    
}
