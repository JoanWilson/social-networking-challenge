//
//  API.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import Foundation

class API {
    
    static func getUsers() async -> [User] {
        let url = URL(string: "\(Constants.BASE_URL)users")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedUsers: [User] = try JSONDecoder().decode([User].self, from: data)
            
            return decodedUsers
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func getUsersById(id: String) async -> User? {
        let url = URL(string: "\(Constants.BASE_URL)users/\(id)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedUser: User = try JSONDecoder().decode(User.self, from: data)
            print(decodedUser)
            return decodedUser
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func createUser(newUser: NewUser) async -> Session? {
        let url = URL(string: "\(Constants.BASE_URL)users")
        var urlRequest = URLRequest(url: url!)
        
        let newUser = NewUser(name: newUser.name, email: newUser.email, password: newUser.password)
        let enconder = JSONEncoder()
        let payload = try! enconder.encode(newUser)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpBody = payload
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedCreateUserResponse: Session = try JSONDecoder().decode(Session.self, from: data)
            print(decodedCreateUserResponse)
            return decodedCreateUserResponse
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func loginSession(email: String, password: String) async -> Session? {
        let url = URL(string: "\(Constants.BASE_URL)users/login")
        var urlRequest = URLRequest(url: url!)
        
        let loginString = NSString(format: "%@:%@", email, password)
        let loginData: NSData = loginString.data(using: String.Encoding.utf8.rawValue)! as NSData
        
        let base64LoginString = loginData.base64EncodedString(options: [])
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedLoginResponse: Session = try JSONDecoder().decode(Session.self, from: data)
//            print(decodedLoginResponse)
            return decodedLoginResponse
        } catch {
            print("Nao deu certo \(error)")
        }
        
        return nil
    }
    
    static func logoutSession(token: String) async -> Session? {
        let url = URL(string: "\(Constants.BASE_URL)users/logout")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedLogoutResponse: Session = try JSONDecoder().decode(Session.self, from: data)
            print(decodedLogoutResponse)
            return decodedLogoutResponse
        } catch {
            print("Nao deu certo \(error)")
        }
        
        return nil
        
    }
    
    static func getCurrentAutenticatedUser(token: String) async -> Bool {
        let url = URL(string: "\(Constants.BASE_URL)users/me")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedUserResponse: Session = try JSONDecoder().decode(Session.self, from: data)
            print(decodedUserResponse)
            return true
        } catch {
            print("Nao deu certo \(error)")
        }
        
        return false
        
    }
    
    static func getPosts() async -> [Post] {
        
        let url = URL(string: "\(Constants.BASE_URL)posts")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
        
        do {
            let decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate]
            
            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                if let date = formatter.date(from: dateString) {
                    return date
                }
                
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            })
            
            do {
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                let allPosts = try decoder.decode([Post].self, from: data)
                
                return allPosts
            } catch {
                return []
            }
        }
    }
    
    static func createPost(content: String, token: String) async -> Post? {
        
        let url = URL(string: "\(Constants.BASE_URL)/posts")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("text/plain", forHTTPHeaderField: "Content-type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = content.data(using: .utf8)!
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedPost: Post = try decoder.decode(Post.self, from: data)
            print(decodedPost)
            return decodedPost
        } catch {
            print("Nao deu certo \(error)")
        }
        
        return nil
        
    }
    
    
}
