//
//  MainTabBarViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 16/08/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.navigationBar.isHidden =  true
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        tabBar.tintColor = .label
        
        let tabBarAppearence = UITabBarAppearance()
        tabBarAppearence.backgroundColor = .systemGroupedBackground
        tabBar.scrollEdgeAppearance = tabBarAppearence
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        let signUpViewController = UINavigationController(rootViewController: SignUpViewController())
        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        
        feedViewController.tabBarItem.image = UIImage(systemName: "doc.text.image")
        feedViewController.tabBarItem.title = "Feed"
        
        signUpViewController.tabBarItem.image = UIImage(systemName: "bitcoinsign.square")
        signUpViewController.tabBarItem.title = "Currencies"
        
        loginViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        loginViewController.tabBarItem.title = "Search"
        
        let viewControllers = [
            feedViewController,
            signUpViewController,
            loginViewController
        ]
        
        setViewControllers(viewControllers, animated: true)
        
    }
    
    
    
    
}
