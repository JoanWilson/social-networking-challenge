//
//  StartViewModel.swift
//  SocialNetworking
//
//  Created by Jamile Castro on 10/08/22.
//

import Foundation

class StartViewModel {
    func loadData() async -> [User] {
        return await API.getUsers()
    }
    
    func loadUser(_ id: String) async -> User {
        return await API.getUsersById(id)
    }
    
//    func createUser(name: String, email: String, password: String) async -> Bool {
//        return await API.createUser(name: name, email: email, password: password)
//    }
}

