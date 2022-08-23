//
//  Session.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 16/08/22.
//

import Foundation

struct Session: Codable {
    let token: String
    let user: User
}


//{
//    "user": {
//        "id": "54E5032F-C5AA-435B-8F1B-F950AEEB9123",
//        "name": "teste2semana",
//        "email": "2semana@teste.br"
//    },
//    "token": "W63QPaR21lUWtwqXc0+ySA=="
//}
