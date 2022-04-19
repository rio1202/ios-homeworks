//
//  PhotosViewController.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 16.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private enum Constant {
        static let itemCount: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        return layout
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollection")
        collectionView.backgroundColor = .white
        
        return collectionView
    }() // создание фото
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photo Gallery"
    }
    
    
    private func setupCollectionView() {
        self.view.addSubview(self.photoCollectionView)
        
        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let needWidth = width - 4 * spacing
        let itemWidth = floor(needWidth / Constant.itemCount)
        
        return CGSize(width: itemWidth, height: itemWidth)
    } // задаем размеры ячейки
}

// MARK: EXTENSIONS

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {  // задаем количество картинок во view
        
        return gameImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollection", for: indexPath) as! PhotosCollectionViewCell
         
            let game = gameImage[indexPath.row]
            let viewModel = PhotosCollectionViewCell.ViewModel(image: game.image)
            cell.setup(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing
        
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ImageAnimationVC = AnimatedPhotoViewController()
        
        let game = gameImage[indexPath.row]
        let viewModel = AnimatedPhotoViewController.ViewModel(image: game.image)
        ImageAnimationVC.setup(with: viewModel)
        
        self.view.addSubview(ImageAnimationVC.view)
        self.addChild(ImageAnimationVC)
        ImageAnimationVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ImageAnimationVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ImageAnimationVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ImageAnimationVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            ImageAnimationVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        ImageAnimationVC.didMove(toParent: self)
    }
}
