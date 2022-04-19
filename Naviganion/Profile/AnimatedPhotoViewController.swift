//
//  File.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 18.04.2022.
//

import UIKit

class AnimatedPhotoViewController: UIViewController {
    
    struct ViewModel: ViewModelProtocol {
        var image: String
    }
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        
        return imageView
    }()
    
    private var widthLargeImage: NSLayoutConstraint?
    private var heightLargeImage: NSLayoutConstraint?
    private var positionXLargeImage: NSLayoutConstraint?
    private var positionYLargeImage: NSLayoutConstraint?
    
    private lazy var transitionButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "cancel")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.alpha = 0.0
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.0)
        setupSubView()
        self.view.layoutIfNeeded()
        moveIn()
    }
    
    
    private func setupSubView() {
        self.view.addSubview(largeImage)
        self.view.addSubview(transitionButton)
        
        self.widthLargeImage = self.largeImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightLargeImage = self.largeImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXLargeImage = self.largeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.positionYLargeImage = self.largeImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.widthLargeImage,
            self.heightLargeImage,
            self.positionXLargeImage,
            self.positionYLargeImage,
            
            self.transitionButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.transitionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.transitionButton.heightAnchor.constraint(equalToConstant: 40),
            self.transitionButton.widthAnchor.constraint(equalToConstant: 40),
        ].compactMap( {$0} ))
    }
    
    func moveIn() {
        NSLayoutConstraint.deactivate([
            self.positionXLargeImage, self.positionYLargeImage, self.widthLargeImage, self.heightLargeImage
        ].compactMap( {$0} ))
        
        self.widthLargeImage = self.largeImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        self.heightLargeImage = self.largeImage.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        self.positionXLargeImage = self.largeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.positionYLargeImage = self.largeImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.positionXLargeImage, self.positionYLargeImage, self.widthLargeImage, self.heightLargeImage
        ].compactMap( {$0} ))
        self.largeImage.layer.cornerRadius = 0.0
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25) {
                self.transitionButton.alpha = 1
            }
        }
    }
    
    func moveOut() {
        NSLayoutConstraint.deactivate([
            self.positionXLargeImage, self.positionYLargeImage, self.widthLargeImage, self.heightLargeImage
        ].compactMap( {$0} ))
        
        self.widthLargeImage = self.largeImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightLargeImage = self.largeImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXLargeImage = self.largeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.positionYLargeImage = self.largeImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.positionXLargeImage, self.positionYLargeImage, self.widthLargeImage, self.heightLargeImage
        ].compactMap( {$0} ))
        self.largeImage.layer.cornerRadius = 70.0
        self.view.backgroundColor = .black.withAlphaComponent(0.8)
        self.transitionButton.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    @objc private func clickButton() {
        moveOut()
    }
}

// MARK: - EXTENSIONS

extension AnimatedPhotoViewController: Setupable { 
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.largeImage.image = UIImage(named: viewModel.image)
    }
}
