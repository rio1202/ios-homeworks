//
//  InfoViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 03.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo

        addButton()
    }
    
    @objc func buttonTapped() {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите все удалить?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ок", style: .default) { (action) in
            print("Фото удалены")
        }
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            print("Действие отменено")
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)

    }
    
    private func addButton() {
        let mainButton = UIButton()
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        mainButton.addTarget(self, action: #selector(InfoViewController.buttonTapped), for: .touchUpInside)
        mainButton.setTitle("Показать", for: .normal)
        mainButton.setTitleColor(.black, for: .normal)
        mainButton.backgroundColor = .green
        
        view.addSubview(mainButton)
        
        let buttonBottomAnchor = mainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        let buttonLeadingAnchor = mainButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let buttonTrailingAnchor = mainButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let buttonHeightAnchor = mainButton.heightAnchor.constraint(equalToConstant: 50) 
        NSLayoutConstraint.activate([buttonBottomAnchor, buttonLeadingAnchor, buttonTrailingAnchor, buttonHeightAnchor].compactMap( {$0} ))
    }
    

    private func showAlert() {
        print("alert")
    }

}
