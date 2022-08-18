
//
//  FeedViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 11/08/22.
//

import UIKit

class FeedViewController: UICollectionViewController {
    
    lazy var subImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        let asset = UIImage(named: "Stars")
        let transparentImage = asset?.image(alpha: 1)
        image.image = transparentImage
        return image
    }()
    
    
    //    let viewModel = FeedViewModel()
    var posts: [Post] = [
        
    ]
    private let cellId = "searchCellId"
    
    @objc func addPost() {
        
        let addPostViewController = AddPostViewController()
        self.present(addPostViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.largeContentTitle = "Space Posts"
        //        navigationController?.navigationBar.isHidden = true
        let navbar = UINavigationBarAppearance()
        navbar.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = navbar
        navigationController?.navigationBar.scrollEdgeAppearance = navbar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPost))
        
        
        title = "Space Posts"
        //        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        //        collectionView.addSubview(subImageView)
        //        subImageView.pinEdges(to: view)
        collectionViewLayout.collectionView?.backgroundView = subImageView
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: cellId)
        
        
        
        Task {
            posts = await API.getPosts()
            collectionView.reloadData()
        }
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchViewCell
        
        cell.myLabel.text = posts[indexPath.row].content
        cell.dateLabel.text = posts[indexPath.row].date
        
        let userID = posts[indexPath.row].user_id
        
        Task {
            let user = await API.getUsersById(id: userID)
            cell.userLabel.text = user?.name
//            self.collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: 200)
    }
    
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            subImageView.topAnchor.constraint(equalTo: view.topAnchor),
            subImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    
    
}

class SearchViewCell: UICollectionViewCell {
    
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


