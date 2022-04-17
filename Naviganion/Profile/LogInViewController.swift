//
//  LoginViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo.jpg"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        return logo
    }()
    
    private lazy var logInTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "E-mail or phone"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "Password"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "blue_pixel")
        button.setTitle("Log in", for: .normal)
        button.setBackgroundImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        drowView()
        tapGesturt()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbdWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func drowView() {
        view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logo)
        self.scrollView.addSubview(logInTextField)
        self.scrollView.addSubview(passwordTextField)
        self.scrollView.addSubview(logInButton)
        
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        
        let logoViewCenterX = self.logo.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let logoViewTopConstraint = self.logo.topAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -193) 
        let logoViewHeightAnchor = self.logo.heightAnchor.constraint(equalToConstant: 100)
        let logoViewWidthAnchor = self.logo.widthAnchor.constraint(equalToConstant: 100)
        
        let logInTextFieldTopConstraint = self.logInTextField.bottomAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 120)
        let logInTextFieldWidthAnchor = self.logInTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let logInTextFieldHeightAnchor = self.logInTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let passwordTextFieldTopConstraint = self.passwordTextField.topAnchor.constraint(equalTo: self.logInTextField.bottomAnchor, constant: -1)
        let passwordTextFieldWidthAnchor = self.passwordTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let logInButtonTopConstraint = self.logInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16)
        let logInButtonWidthAnchor = self.logInButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let logInButtonHeightAnchor = self.logInButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            scrollViewTopConstraint, scrollViewRightConstraint,
            scrollViewBottomConstraint,scrollViewLeftConstraint,
            logoViewCenterX, logoViewTopConstraint,
            logoViewWidthAnchor, logoViewHeightAnchor,
            logInTextFieldTopConstraint, logInTextFieldWidthAnchor,
            logInTextFieldHeightAnchor,
            passwordTextFieldTopConstraint, passwordTextFieldWidthAnchor,
            passwordTextFieldHeightAnchor,
            logInButtonTopConstraint, logInButtonWidthAnchor,
            logInButtonHeightAnchor
        ])
    }
    
    @objc private func buttonAction() {
        let controller = ProfileViewController()
        self.navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: EXTENSIONS
extension LogInViewController {
    
    func tapGesturt() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func kbdWillShow(_ notification: Notification) {
        
        if let kbdSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let kbdRectangle = kbdSize.cgRectValue
            let kbdHeight = kbdRectangle.height
            let LogInButtonBottomY = self.logInButton.frame.origin.y + logInButton.frame.height
            let kbdOriginY = self.view.frame.height - kbdHeight
            let contentOffset = kbdOriginY < LogInButtonBottomY ? LogInButtonBottomY - kbdOriginY + 32 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
        }
    }
    
    @objc private func kbdWillHide(_ notification: Notification) {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
