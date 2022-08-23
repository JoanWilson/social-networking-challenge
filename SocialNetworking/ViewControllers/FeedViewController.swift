
//
//  FeedViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 11/08/22.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var subImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        let asset = UIImage(named: "Stars")
        let transparentImage = asset?.image(alpha: 1)
        image.image = transparentImage
        return image
    }()
    
    var posts: [Post] = []
    
    private let cellId = "searchCellId"
    
    @objc func addPost() {
        
        let addPostViewController = AddPostViewController()
        self.present(addPostViewController, animated: true)
    }
    
    @objc func logout() {
        self.navigationController?.pushViewController(LoginViewController(), animated: false)
        KeychainHelper.standard.delete(service: "access-token", account: "space-networking")
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        self.navigationItem.hidesBackButton = true
        let navbar = UINavigationBarAppearance()
        navbar.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = navbar
        navigationController?.navigationBar.scrollEdgeAppearance = navbar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPost))
        
        let logoutBarButton =  UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        logoutBarButton.tintColor = .red
        
        navigationItem.leftBarButtonItem = logoutBarButton
        
        
        title = "Space Posts"
        collectionViewLayout.collectionView?.backgroundView = subImageView
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        
        Task {
            posts = await API.getPosts()
            collectionView.reloadData()
        }
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCollectionViewCell
        
        cell.myLabel.text = posts[indexPath.row].content
        cell.dateLabel.text = posts[indexPath.row].date
        
        let userID = posts[indexPath.row].user_id
        
        Task {
            let user = await API.getUsersById(id: userID)
            cell.userLabel.text = user?.name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
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
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            subImageView.topAnchor.constraint(equalTo: view.topAnchor),
            subImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

