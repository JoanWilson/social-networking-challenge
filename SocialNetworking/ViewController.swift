//
//  ViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import UIKit

class ViewController: UIViewController {
    
//    let viewModel = StartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        Task {
//            let newUser = NewUser(name: "Milena", email: "milenateste@teste.br", password: "batman")
//            let user = await API.createUser(newUser: newUser)
            let data = await API.logoutSession(token: "ppoJE7Uj6sGFZV7ZQdVO5w==")
//            let data = await viewModel.loadData()
//            let user = await viewModel.loadUser("055D73CE-A402-4495-81EF-57BA2F3A6F73")
            
            print(data)
        }
        
    }
    
   

}


