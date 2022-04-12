//
//  FeedViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 01.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Hello world")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        addButton()
    }
    

    @objc func buttonTapped() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: false)
        postVC.titelText = post.title

    }
    
    private func addButton() {
        let mainButton = UIButton()
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        mainButton.addTarget(self, action: #selector(FeedViewController.buttonTapped), for: .touchUpInside)
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
}

