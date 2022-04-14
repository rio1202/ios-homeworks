//
//  ProfileViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 06.04.2022.
//

import UIKit

final class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var titleTextField: UITextField = { // Устанавливаем текстовое поле
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = "Set title"
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true

        return textField
    }()
    
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Установить заголовок", for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(self.titleButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    weak var delegate: (ProfileHeaderViewProtocol)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    
     func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }
    
    
    private func setupView() {
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.profileHeaderView)
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 170)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, self.heightConstraint
        ].compactMap({ $0 }))
        
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleButton)
        let guide = view.safeAreaLayoutGuide
        titleButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        titleButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        titleButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.centerXAnchor.constraint(equalTo: titleButton.centerXAnchor).isActive = true
        titleTextField.bottomAnchor.constraint(equalTo: titleButton.topAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    
    @objc private func titleButtonAction() {
        
        if self.titleTextField.isHidden {
            titleTextField.isHidden = false
        } else {
            titleTextField.isHidden = true
            self.navigationItem.title = titleTextField.text!
            titleTextField.text = nil
        }
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 214 : 170 //214 : 170
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
