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
        
        let horizontalCenter = NSLayoutConstraint(item: mainButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        let verticalCenter = NSLayoutConstraint(item: mainButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let width = NSLayoutConstraint(item: mainButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 200)
        
        let hight = NSLayoutConstraint(item: mainButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)
        
        let constraints: [NSLayoutConstraint] = [horizontalCenter, verticalCenter, width, hight]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showAlert() {
        print("alert")
    }

}
