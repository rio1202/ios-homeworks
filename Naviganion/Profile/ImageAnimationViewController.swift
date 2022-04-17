//
//  ImageAnimationViewController.swift
//  Navigation
//
//  Created by Daniil Ivanov on 16.04.2022.
//

import UIKit

class ImageAnimationViewController: UIViewController {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Cat.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var widthAvatarImage: NSLayoutConstraint?
    private var heightAvatarImage: NSLayoutConstraint?
    private var positionXAvatarImage: NSLayoutConstraint?
    private var positionYAvatarImage: NSLayoutConstraint?
    
    private lazy var transitionButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "cancel")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.0)
        drowSelf()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveIn()
    }
    
    
    private func drowSelf() {
        self.view.addSubview(avatarImage)
        self.view.addSubview(transitionButton)
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXAvatarImage = self.avatarImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        self.positionYAvatarImage = self.avatarImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        
        let buttonTopConstrain = self.transitionButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let buttonTrailingConstraint = self.transitionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.transitionButton.heightAnchor.constraint(equalToConstant: 40)
        let buttonWidthConstraint = self.transitionButton.widthAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([
            self.widthAvatarImage, self.heightAvatarImage,
            self.positionXAvatarImage, self.positionYAvatarImage,
            buttonTopConstrain, buttonTrailingConstraint,
            buttonHeightConstraint, buttonWidthConstraint
        ].compactMap( {$0} ))
    }
    
    private func moveIn() {
        NSLayoutConstraint.deactivate([
            self.positionXAvatarImage, self.positionYAvatarImage,
            self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        self.positionXAvatarImage = self.avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.positionYAvatarImage = self.avatarImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.positionXAvatarImage, self.positionYAvatarImage,
            self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        
        
        UIView.animate(withDuration: 1.5, animations: {
            self.avatarImage.layer.cornerRadius = 12
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.transitionButton.alpha = 2
            UIView.animate(withDuration: 0.7, animations: {
                self.avatarImage.layer.cornerRadius = 0
                self.view.layoutIfNeeded()
            })
        })
    }
    
    func moveOut() {
        NSLayoutConstraint.deactivate([
            self.positionXAvatarImage, self.positionYAvatarImage,
            self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXAvatarImage = self.avatarImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        self.positionYAvatarImage = self.avatarImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        
        NSLayoutConstraint.activate([
            self.positionXAvatarImage, self.positionYAvatarImage,
            self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        self.transitionButton.alpha = 0.0
        self.avatarImage.layer.cornerRadius = 70.0
        
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
    @objc private func actionButton() {
        moveOut()
    }
}
