//
//  BaseViewController.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 11/10/2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var indicatorBlurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.makeConstraints()
    }
    
    func setUpUI() {
        
        //TODO: - change colour
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.2196078431, blue: 0.3882352941, alpha: 1)
        
        //TODO: -  fix me
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 24),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    
        self.navigationController?.navigationBar.tintColor = .gray
    
        self.addSubviews()
        self.makeConstraints()
    }
    
    
    func addSubviews() {
        self.view.addSubview(indicatorBlurView)
        self.indicatorBlurView.contentView.addSubview(indicator)
    }
    
    func makeConstraints() {
        
//        indicatorBlurView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        indicator.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
    }
    
    // MARK: Functions
    func showActivityIndicator() {
        self.indicatorBlurView.isHidden = false
        self.view.bringSubviewToFront(self.indicatorBlurView)
        self.indicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.indicatorBlurView.isHidden = true
        self.indicator.stopAnimating()
    }
    
    // MARK: Change to RxSwift
    func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardStartSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.handleKeyboardHeight(rect: keyboardStartSize)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let swipeGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboardOnSwipe))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        self.handleTapGesture()
        view.endEditing(true)
    }
    
    @objc func dismissKeyboardOnSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            self.dismissKeyboard()
        }
    }
    
    func handleKeyboardHeight(rect: CGRect) {
    }
    
    func handleTapGesture() {
    }
}
