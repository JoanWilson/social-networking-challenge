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
    
    func getUsersById(_ id: String) async -> User {
        let url = URL(string: "\(Constants.BASE_URL)users/\(id)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let decodedUser: User = try JSONDecoder().decode(User.self, from: data)
            print(decodedUser)
            return decodedUser
        } catch {
            print(error)
            fatalError("\(error)")
        }
        
        
    }
    
    func createUser(name: String, email: String, password: String) async -> Bool {
        let url = URL(string: "\(Constants.BASE_URL)users")
        let newUser = NewUser(name: name, email: email, password: password)
        
        let userPayload = try! JSONEncoder().encode(newUser)
        let userPayloadJSON = String(data: userPayload, encoding: String.Encoding.utf16)
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpBody = userPayload
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let string = String(data: data, encoding: .utf8)
            print(string)
            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 201)
            }
            
        } catch {
            print(error)
            fatalError("\(error)")
        }
        
        return false
    }
    
    func loginUser(email: String, password: String) async -> Bool {
        let url = URL(string: "\(Constants.BASE_URL)users/login")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpBody = userPayload
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let string = String(data: data, encoding: .utf8)
            print(string)
            if let responseHeader = response as? HTTPURLResponse {
                return (responseHeader.statusCode == 201)
            }
            
        } catch {
            print(error)
            fatalError("\(error)")
        }
        
        return false
    }
}
