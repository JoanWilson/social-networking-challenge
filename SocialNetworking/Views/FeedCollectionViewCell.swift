//
//  FeedCollectionViewCell.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 18/08/22.
//

import Foundation
import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is label view."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 8
        label.accessibilityScroll(.down)
        return label
    }()
    
    lazy var backgroundRectangle: UIView = {
        let rectangle = UIView()
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.layer.backgroundColor = UIColor.white.cgColor
        rectangle.layer.cornerRadius = 8
        rectangle.layer.masksToBounds = true
        return rectangle
    }()
    
    
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.imageView?.image = favoriteImage
        var configuration = UIButton.Configuration.plain()
        configuration.image = favoriteImage
        configuration.title = "Like"
        configuration.baseForegroundColor = .systemRed
        configuration.buttonSize = .mini
        button.configuration = configuration
        button.addTarget(self, action: #selector(favoriteAnPost), for: .touchUpInside)
        //        button.layer.backgroundColor = UIColor.green.cgColor
        return button
    }()
    
    var isFavorite: Bool = false
    var favoriteImage: UIImage {
        return UIImage(systemName: "heart" + (isFavorite ? ".fill" : ""))!.withTintColor(.red)
    }
    var favoriteTitle: String {
        return isFavorite ? "Dislike" : "Like"
    }
    
    @objc func favoriteAnPost(sender: UIButton!){
        
        self.isFavorite = !isFavorite
        var configuration = sender.configuration
        configuration?.image = favoriteImage
        configuration?.title = favoriteTitle
        sender.configuration = configuration
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10/10/2022"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        label.accessibilityScroll(.down)
        return label
    }()
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome Sobrenome: "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 1
        label.accessibilityScroll(.down)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundRectangle)
        contentView.addSubview(userLabel)
        contentView.addSubview(myLabel)
        contentView.addSubview(dateLabel)
        contentView.backgroundColor = .clear
        contentView.addSubview(favoriteButton)
        
        
        configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
        
            
            myLabel.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor, constant: 25),
            myLabel.trailingAnchor.constraint(equalTo: backgroundRectangle.trailingAnchor, constant: -20),
            myLabel.topAnchor.constraint(equalTo: userLabel.topAnchor, constant: 30),
            myLabel.bottomAnchor.constraint(equalTo: backgroundRectangle.bottomAnchor, constant: -40),
            
            dateLabel.bottomAnchor.constraint(equalTo: backgroundRectangle.bottomAnchor, constant: -15),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundRectangle.trailingAnchor, constant: -20),
            
            userLabel.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor, constant: 25),
            userLabel.topAnchor.constraint(equalTo: backgroundRectangle.topAnchor, constant: 15),
            
            
            
            backgroundRectangle.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundRectangle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            //            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            //            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.bottomAnchor.constraint(equalTo: backgroundRectangle.bottomAnchor, constant: -10),
            favoriteButton.leadingAnchor.constraint(equalTo: backgroundRectangle.leadingAnchor, constant: 10),
        ])
    }
}


