//
//  Post.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 16/08/22.
//

import Foundation

struct Post: Codable {
    let id: String
    let content: String
    let user_id: String
    let created_at: Date
    let updated_at: Date
}
