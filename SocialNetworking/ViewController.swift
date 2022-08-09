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
            await loadData()
        }
        
    }
    
    func loadData() async -> [User] {
        let url = URL(string: "\(Constants.BASE_URL)users")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let decodedUsers: [User] = try JSONDecoder().decode([User].self, from: data)
            print(data)
            print(decodedUsers)
            return decodedUsers
        } catch {
            print(error)
        }
        
        return []
    }

}

