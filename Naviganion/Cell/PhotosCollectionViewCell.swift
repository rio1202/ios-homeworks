//
//  PhotosCollectionViewCell.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 16.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel: ViewModelProtocol {
        var image: String
    }
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupPhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhotoView() {
        self.addSubview(photoView)
        setupConstraints()
    }
    
    override func prepareForReuse() { // сбрасываем значение в ячейках
        super.prepareForReuse()
        self.photoView.image = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.photoView.topAnchor.constraint(equalTo: self.topAnchor),
            self.photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: EXTENSIONS
extension PhotosCollectionViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.photoView.image = UIImage(named: viewModel.image)
    }
}
