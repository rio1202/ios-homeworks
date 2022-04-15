//
//  ProfileTableHederView.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import UIKit

class ProfileTableHederView: UITableViewHeaderFooterView, UITextFieldDelegate, UIGestureRecognizerDelegate {

    private var newStatustext: String = ""

    private lazy var avatarImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 76
        imageView.clipsToBounds = true

        return imageView
    }() // Создание аватара с котом

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

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
        textField.isHidden = true
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
    }() // создание текстового поля ввода текста

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
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

    private var buttonTopConstraint: NSLayoutConstraint?

    weak var delegate: ProfileHeaderViewProtocol?

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
        
        self.statusTextField.delegate = self

        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let imageViewAspectRatio = self.avatarImageview.heightAnchor.constraint(equalTo: self.avatarImageview.widthAnchor, multiplier: 1.0)

        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 45)

        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, imageViewAspectRatio,
            self.buttonTopConstraint, leadingButtonConstraint,
            trailingButtonConstraint, bottomButtonConstraint, heightButtonConstraint
        ].compactMap({ $0 }))
    } // создаем констреинты и добавляем элементы на view

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    @objc private func buttonAction() {

            let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -10)
            let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
            let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
            self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 20)

        statusTextField.becomeFirstResponder()

        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            statusTextField.text = ""
            setStatusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstraint?.isActive = false
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
            ].compactMap({ $0 }))
        } else {

            newStatustext = statusTextField.text ?? ""
            statusLabel.text = statusTextField.text
            statusLabel.text = newStatustext
            setStatusButton.setTitle("Show status", for: .normal)
            textFieldDidChange(statusTextField)
            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint].compactMap( {$0} ))
        }


        self.delegate?.buttonAction(inputTextIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        print(text)
    }
}

