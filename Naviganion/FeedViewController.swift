//
//  FeedViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 01.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Пост")
        
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }() // Стек для двух кнопок

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside) 
        button.translatesAutoresizingMaskIntoConstraints = false
     
        return button
    }() // первая кнопка перехода
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
     
        return button
    }() // вторая кнопка перехода
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setButtonStackView()
        
    }
    
    func setButtonStackView() {
        self.view.addSubview(self.buttonStackView)
        self.buttonStackView.addArrangedSubview(firstButton)
        self.buttonStackView.addArrangedSubview(secondButton)
        
        let buttonStackViewCenterY = self.buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let buttonStackViewLeadingConstraint = self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let buttonStackViewTrailingConstraint = self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)

        
        let firstButtonHeightAnchor = self.firstButton.heightAnchor.constraint(equalToConstant: 40)
        let secondButtonHeightAnchor = self.secondButton.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([buttonStackViewCenterY, buttonStackViewLeadingConstraint,
                                     buttonStackViewTrailingConstraint, firstButtonHeightAnchor,
                                     secondButtonHeightAnchor
                                    ].compactMap( {$0} ))
    } // Настраиваем констрейнты для стека
    
    @objc private func buttonAction() {
        firstButton.addTarget(self, action: #selector(FeedViewController.buttonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(FeedViewController.buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
        postVC.titelText = post.title

    }
    
}

