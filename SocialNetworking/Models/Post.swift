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
    let created_at: Date?
    let updated_at: Date?
    
    var date: String {
        let dateFormatter = updated_at?.getFormattedDate(format: "MMM d, yyyy")
        guard let date = dateFormatter else {
            return ""
        }
        
        return date
    }
}


struct NewPost: Codable {
    let content: String
    let token: String
}
