//
//  ProfileHeaderView.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 06.04.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView, UITextFieldDelegate {

    private var newStatustext: String = ""

    private lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 42
        imageView.clipsToBounds = true

        return imageView
    }() // Создание аватара с котом

    private lazy var nameLabel: UILabel = {
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

    private lazy var textField: UITextField = {
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

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12.0
        
        return button
    }() // создаем кнопку "Show status"

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.textField)
        self.infoStackView.addArrangedSubview(self.imageview)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.nameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        
        self.textField.delegate = self

        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let imageViewAspectRatio = self.imageview.heightAnchor.constraint(equalTo: self.imageview.widthAnchor, multiplier: 1.0)

        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)

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
    


    @objc private func didTapStatusButton() {

            let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: -10)
            let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
            let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 54)
            self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)

        textField.becomeFirstResponder()

        if self.textField.isHidden {
            self.addSubview(self.textField)
            textField.text = ""
            statusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstraint?.isActive = false
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
            ].compactMap({ $0 }))
        } else {

            newStatustext = textField.text ?? ""
            statusLabel.text = textField.text
            statusLabel.text = newStatustext
            statusButton.setTitle("Show status", for: .normal)
            textFieldDidChange(textField)
            self.textField.removeFromSuperview()
            NSLayoutConstraint.deactivate([topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint].compactMap( {$0} ))
        }


        self.delegate?.didTapStatusButton(textFieldIsVisible: self.textField.isHidden) { [weak self] in
            self?.textField.isHidden.toggle()
        }
    } // обработчик нажатия кнопки

    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        print(text)
    }
}


