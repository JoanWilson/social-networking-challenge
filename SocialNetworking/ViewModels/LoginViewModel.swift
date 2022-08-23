//
//  LoginViewModel.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 16/08/22.
//

import Foundation

class LoginViewModel {
    func loginUser(email: String, password: String) async -> Session? {
        return await API.loginSession(email: email, password: password)
    }
}
