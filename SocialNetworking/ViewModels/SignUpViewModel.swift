//
//  StartViewModel.swift
//  SocialNetworking
//
//  Created by Jamile Castro on 10/08/22.
//

import Foundation

class SignUpViewModel {
    func createNewUser(newUser: NewUser) async -> Session? {
        return await API.createUser(newUser: newUser)
    }
    
    
}


