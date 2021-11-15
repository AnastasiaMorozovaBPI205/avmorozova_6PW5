//
//  ArticleTableViewCell.swift
//  avmorozova_6PW5
//
//  Created by Anastasia on 09.11.2021.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    private var articleImageView = UIImageView()
    private var imageURL: URL?
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    private var articleImage: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak articleImageView, articleImage] in
                articleImageView?.image = articleImage
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        articleImageView.image = nil
    }
    
    public func setupArticleCell(title: String?, description: String?, url: URL?) {
        self.backgroundColor = .black
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        
        self.setHeight(to: 320)
        
        setupTitleLabel(title: title)
        setupDescriptionLabel(description: description)
        setupImage(url: url)
    }
    
    private func setupTitleLabel(title: String?) {
        self.addSubview(titleLabel)
        
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 3
        titleLabel.setHeight(to: 70)
        titleLabel.setWidth(to: 300)
        
        titleLabel.textColor = .white
        titleLabel.text = title
        
        titleLabel.pinLeft(to: leadingAnchor, 10)
        titleLabel.pinTop(to: topAnchor, 20)
    }
    
    private func setupDescriptionLabel(description: String?) {
        addSubview(descriptionLabel)
        
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.numberOfLines = 4
        descriptionLabel.setHeight(to: 100)
        descriptionLabel.setWidth(to: 300)
        
        descriptionLabel.text = description
        descriptionLabel.textColor = .white
        
        descriptionLabel.setWidth(to: 300)
        
        descriptionLabel.pinLeft(to: leadingAnchor, 10)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 10)
    }
    
    private func setupImage(url: URL?) {
        imageURL = url
        
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true;
        
        articleImageView.setHeight(to: 100)
        articleImageView.setWidth(to: 150)
        
        self.addSubview(articleImageView)
        
        articleImageView.pinLeft(to: leadingAnchor, 80)
        
        articleImageView.pinTop(to: descriptionLabel.bottomAnchor, 10)
        
        loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global().async { [weak self] in
            guard
                let url = self?.imageURL,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else {
                return
            }
            
            self?.articleImage = image
        }
    }
}
