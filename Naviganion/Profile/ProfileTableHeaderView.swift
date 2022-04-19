//
//  ProfileTableHeaderView.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import UIKit

protocol ProfileTableHeaderViewProtocol: AnyObject {
    func buttonAction()
    
    func delegateActionAnimatedAvatar(cell: ProfileTableHeaderView)
}

class ProfileTableHeaderView: UITableViewHeaderFooterView  { 
    
    private var newStatustext: String?
    
    private lazy var avatarImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        
        return imageView
    }() // Создание аватара с котом
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }() // лейбл текст
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Waiting for something..."
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.delegate = self
        
        return textField
    }() // создание текстового поля ввода текста
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12.0
        
        return button
    }() // создаем кнопку "Show status"
    
    private lazy var titleTextField: UITextField = { // Устанавливаем текстовое поле
        let textField = UITextField()
        textField.isHidden = false
        textField.placeholder = "Waiting for something..."
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
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }() // вертикальный стек
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }() // горизонтальный стек
    
    weak var delegate: ProfileTableHeaderViewProtocol?
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.setStatusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageview)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        setupTapGesture()
        
        self.statusTextField.delegate = self
        NSLayoutConstraint.activate([
            self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.avatarImageview.widthAnchor.constraint(equalToConstant: 138),
            self.avatarImageview.heightAnchor.constraint(equalToConstant: 138),
            
            self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -10),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.labelsStackView.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    } // создаем констреинты и добавляем элементы на view
    
    
    @objc func buttonAction() {
        guard statusTextField.text != "" else {
            statusTextField.shake()
            return
        }
        newStatustext = self.statusTextField.text!
        statusLabel.text = "\(newStatustext ?? "")"
        self.statusTextField.text = nil
        self.endEditing(true)
    }
}



// MARK: - EXTENSIONS
extension ProfileTableHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension ProfileTableHeaderView: UIGestureRecognizerDelegate {
    
    private func setupTapGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageview.addGestureRecognizer(self.tapGestureRecognizer)
        self.avatarImageview.isUserInteractionEnabled = true
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        delegate?.delegateActionAnimatedAvatar(cell: self)
    }
}

