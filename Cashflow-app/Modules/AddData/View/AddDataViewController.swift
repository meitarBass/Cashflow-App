//
//  CustomAlertController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit
import SnapKit

enum FlowType {
    case expense
    case income
}

class AddDataViewController: BaseViewController {
    
    var presenter: AddDataPresenterProtocol?
    
    private lazy var dateView: CustomDataView = {
        let view = CustomDataView(frame: .zero, title: "Date", message: "", color: .buttonColor)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateClicked))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var categoryView: CustomDataView = {
        let view = CustomDataView(frame: .zero, title: "Category", message: "", color: .buttonColor)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(categoryClicked))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var amountView: CustomDataView = {
        let view = CustomDataView(frame: .zero, title: "Amount", message: "", color: .buttonColor)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(amountClicked))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateView, categoryView, amountView])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
        button.setTitle("Add new expense", for: .normal)
        button.titleLabel?.font = .bold20
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .buttonColor
        return button
    }()
    
    private lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.delegate = self
        picker.dataSource = self
        #warning("change background color")
        picker.backgroundColor = .systemPink
        return picker
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.maximumDate = .init()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        #warning("change background color")
        picker.backgroundColor = .systemPink
        return picker
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0,
                                              width: 100, height: 100))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboardFromToolBar))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI(color: #colorLiteral(red: 0.1647058824, green: 0.2196078431, blue: 0.3882352941, alpha: 1), flowType: .expense)
    }

    private func setupUI(color: UIColor, flowType: FlowType) {
        view.backgroundColor = color
        switch flowType {
        case .expense:
            self.title = "New expense"
        case .income:
            self.title = "New income"
        }
        
        addSubviews()
        makeConstraints()
    }
    
    override func addSubviews() {
        self.view.addSubview(dataStackView)
        self.view.addSubview(addButton)
    }
    
    override func makeConstraints() {
        dataStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(48)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(36)
            make.height.equalTo(36)
        }
    }
    
    
}

// MARK: Fields to manipulate the data - Date / Category / Amount
extension AddDataViewController {
    
    private func changeAmount() {
        let alert = UIAlertController(title: "Add amount",
                                      message: "Please enter your amount",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "0$"
        }
        guard let tf = alert.textFields?[0] else { return }
        tf.keyboardType = .numberPad
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (alert) in
            guard let tfText = tf.text else { return }
            self.amountView.changeMessage(withText: tfText + "$")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: Buttons
extension AddDataViewController {
    @objc private func addClicked() {
        presenter?.addNewData(data: DataModel(date: dateView.getValue(),
                                              amount: amountView.getValue(),
                                              category: categoryView.getValue()))
    }
    
    @objc private func dateClicked() {
        setDatePickerUI()
        setToolBarUI(picker: datePicker)
    }
    
    @objc private func categoryClicked() {
        setCategoryPickerUI()
        setToolBarUI(picker: categoryPicker)
    }
    
    @objc private func amountClicked() {
        changeAmount()
    }
    
    @objc private func dismissKeyboardFromToolBar() {
        if datePicker.isDescendant(of: self.view) {
            datePicker.removeFromSuperview()
            getDate()
        } else if categoryPicker.isDescendant(of: self.view) {
            categoryPicker.removeFromSuperview()
        }
        toolBar.removeFromSuperview()
    }
}

// MARK: UICategoryPickerView

extension AddDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categories.categoriesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Categories.categoriesArr[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryView.changeMessage(withText: Categories.categoriesArr[row].rawValue)
    }
    
    func setCategoryPickerUI() {
        addCategoryPickerView()
        createCategoryPickerConstraints()
    }
    
    func addCategoryPickerView() {
        self.view.addSubview(categoryPicker)
    }
    
    func createCategoryPickerConstraints() {
        categoryPicker.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}

// MARK: UIDatePickerView

extension AddDataViewController {
    
    func getDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        dateView.changeMessage(withText: selectedDate)
    }
    
    private func setDatePickerUI() {
        addDatePickerView()
        createDatePickerConstraints()
    }
    
    private func addDatePickerView() {
        self.view.addSubview(datePicker)
    }
    
    private func createDatePickerConstraints() {
        datePicker.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}

// MARK: Handling tool bar stuff
extension AddDataViewController {
    private func setToolBarUI(picker: UIView) {
        addToView()
        setToolBarConstraints(picker: picker)
    }
    
    private func addToView() {
        self.view.addSubview(toolBar)
    }
    
    private func setToolBarConstraints(picker: UIView) {
        toolBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(picker.snp.topMargin)
        }
    }
}
