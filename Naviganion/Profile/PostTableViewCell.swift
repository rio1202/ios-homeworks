//
//  PostTableViewCell.swift
//  Naviganion
//
//  Created by Daniil Ivanov on 15.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        var author: String
        var description: String
        var image: String
        var likes: Int
        var views: Int
    }
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }() // заголовок поста
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }() // картинка в посте
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }() // Блок текста статьи
    
    private lazy var likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }() // стэк лайков и просмотров
    
    private lazy var likeTitle: UILabel = {
        let label = UILabel()
        label.text  = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }() // лайк
    
    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text  = "Views: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }() //просмотры
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.postImage.image = nil
        self.descriptionLabel.text = nil
        self.likeTitle.text = nil
        self.viewTitle.text = nil
    }
    
    private func drawSelf() {
        self.contentView.addSubview(self.authorLabel)
        self.contentView.addSubview(self.postImage)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.likeStackView)
        self.likeStackView.addArrangedSubview(self.likeTitle)
        self.likeStackView.addArrangedSubview(self.viewTitle)

        let topConstraintAuthorLabel = self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leadingConstraintAuthorLabel = self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraintAuthorLabel = self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let topConstraintPostImageView = self.postImage.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12)
        let leadingConstraintPostImageView = self.postImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraintPostImageView = self.postImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let widthPostImageView = self.postImage.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1.0)
        let topConstraintDescriptionLabel = self.descriptionLabel.topAnchor.constraint(equalTo: self.postImage.bottomAnchor, constant: 16)
        let leadingConstraintDescriptionLabell = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraintDescriptionLabel = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let topConstraintLikeStackView = self.likeStackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingConstraintLikeStackView = self.likeStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraintLikeStackView = self.likeStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let bottomConstraintLikeStackView = self.likeStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            topConstraintAuthorLabel, topConstraintPostImageView,widthPostImageView,
            leadingConstraintAuthorLabel, trailingConstraintAuthorLabel,
            topConstraintDescriptionLabel, leadingConstraintDescriptionLabell,
            trailingConstraintDescriptionLabel, topConstraintLikeStackView,
            leadingConstraintLikeStackView, trailingConstraintLikeStackView,
            bottomConstraintLikeStackView, leadingConstraintPostImageView,
            trailingConstraintPostImageView
        ])
    }// Добавляем элементы и создаем констреинты
}

// MARK: EXTENSIONS
extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.authorLabel.text = viewModel.author
        self.postImage.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        let like = String(viewModel.likes)
        let views = String(viewModel.views)
        self.likeTitle.text = "Likes: " + like
        self.viewTitle.text = "Views: " + views
    }
} //создание модели данных
