//
//  API.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import Foundation

class API {
    
    func getUsers() async -> [User] {
        let url = URL(string: "\(Constants.BASE_URL)users")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let decodedUsers: [User] = try JSONDecoder().decode([User].self, from: data)
            return decodedUsers
        } catch {
            print(error)
        }
        
        return []
    }
    
    func getUsersById() async -> [User] {
        let url = URL(string: "\(Constants.BASE_URL)")
    }
    
}
