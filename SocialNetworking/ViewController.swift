//
//  ViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        Task {
            let data = await loadData()
            print(data)
        }
        
    }
    
    func loadData() async -> [User] {
        return await API().getUsers()
    }

}

