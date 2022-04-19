//
//  LoginViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    let user = User(login: "1@q.ru", password: "0000")
    
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
    }() // поле E-mail or phone
    
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
    }() // поле Password
    
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
    }() // Log in
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        drowView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbdWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbdWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func drowView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logo)
        self.scrollView.addSubview(logInTextField)
        self.scrollView.addSubview(passwordTextField)
        self.scrollView.addSubview(logInButton)
        self.view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            self.logo.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.logo.topAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -193),
            self.logo.heightAnchor.constraint(equalToConstant: 100),
            self.logo.widthAnchor.constraint(equalToConstant: 100),
            
            self.logInTextField.bottomAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 120),
            self.logInTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.logInTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.logInTextField.bottomAnchor, constant: -1),
            self.passwordTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.logInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16),
            self.logInButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.errorLabel.bottomAnchor.constraint(equalTo: self.logInTextField.topAnchor, constant: -16),
            self.errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        ])
    } // отрисовка view
    
    @objc private func buttonAction() {
        if isEmpty(textField: logInTextField), validationEmail(textField: logInTextField),
           isEmpty(textField: passwordTextField), validationPassword(textField: passwordTextField) {
            let controller = ProfileViewController()
            self.navigationController?.pushViewController(controller, animated: true)
            navigationController?.navigationBar.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func checkCount(inputString: UITextField, givenString: String) {
        guard inputString.text!.count < givenString.count - 1 ||
                inputString.text!.count > givenString.count - 1 else {
            errorLabel.text = ""
            
            return
        }
        errorLabel.textColor = .red
        errorLabel.text = "\(String(describing: inputString.placeholder!)) содержит \(givenString.count) символов"
    }
}

// MARK: EXTENSIONS
extension LogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // ПРОВЕРКА КОЛИЧЕСВА ВВЕДЕННЫХ СИМВОЛОВ
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        if textField == logInTextField {
            checkCount(inputString: logInTextField, givenString: user.login)
        } else {
            checkCount(inputString: passwordTextField, givenString: user.password)
        }
        textField.text = result
        
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // СПРЯТАТЬ КЛАВИАТУРУ ПО RETURN
        self.view.endEditing(true)
        return false
    }
}

extension LogInViewController {
    
    private func isEmpty(textField: UITextField) -> Bool { // ПОТРЯХИВАНИЕ ПУСТОГО TEXTFIELD
        guard textField.text != "" else {
            textField.shake()
            
            return false
        }
        
        return true
    }
    
    private func validationEmail(textField: UITextField) -> Bool { // ПРОВЕРКА ЛОГИНА
        
        guard textField.text!.isValidEmail, textField.text == user.login else {
            openAlert(title: "Ошибка",
                      message: "Неверный почтовый адрес",
                      alertStyle: .alert, actionTitles: ["Повторить"],
                      actionStyles: [.default],
                      actions: [{ _ in
                print("Ошибка")
            }])
            
            return false
        }
        
        return true
    }
    
    private func validationPassword(textField: UITextField) -> Bool { // ПРОВЕРКА ПАРОЛЯ
        
        guard textField.text == user.password else {
            openAlert(title: "Ошибка",
                      message: "Неверный пароль",
                      alertStyle: .alert, actionTitles: ["Повторить"],
                      actionStyles: [.default],
                      actions: [{ _ in
                print("Ошибка")
            }])
            
            return false
        }
        
        return true
    }
    
    
    
    @objc private func kbdWillShow(_ notification: Notification) {
        
        if let kbdSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let kbdRectangle = kbdSize.cgRectValue
            let kbdHeight = kbdRectangle.height
            let LogInButtonBottomY = self.logInButton.frame.origin.y + logInButton.frame.height
            let kbdOriginY = self.view.frame.height - kbdHeight
            let contentOffset = kbdOriginY < LogInButtonBottomY ? LogInButtonBottomY - kbdOriginY + 50 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
        }
    } // показать клавиатуру
    
    @objc private func kbdWillHide(_ notification: Notification) {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    } // спрятать клавиатуру
}
