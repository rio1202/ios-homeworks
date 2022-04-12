//
//  PostViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 01.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titelText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        self.navigationItem.title = titelText
        let myButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showModal))
        navigationItem.rightBarButtonItem = myButton
        
        
    }
    
    @objc func showVC() {
        let infoVC =  InfoViewController()
        navigationController?.pushViewController(infoVC, animated: false)
    }
    
    @objc func showModal() {
        let modalDatePicker : UIViewController = InfoViewController()
        modalDatePicker.modalPresentationStyle = .overCurrentContext
        modalDatePicker.modalPresentationStyle = .automatic
        modalDatePicker.modalTransitionStyle = .crossDissolve
        self.present(modalDatePicker, animated: true, completion: nil)
    }
}
