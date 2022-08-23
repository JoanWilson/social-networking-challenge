//
//  User.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 09/08/22.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
}

struct NewUser: Codable {
    let name: String
    let email: String
    let password: String
}
