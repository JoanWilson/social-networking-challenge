//
//  ViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = StartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        Task {
            let create = await viewModel.createUser(name: "teste1222sasa", email: "1222Milenasasa4@teeeste.ada", password: "teste")
//            let data = await viewModel.loadData()
//            let user = await viewModel.loadUser("055D73CE-A402-4495-81EF-57BA2F3A6F73")
            
            print(create)
        }
        
    }
    
   

}


