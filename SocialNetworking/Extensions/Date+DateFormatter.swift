//
//  Date+DateFormatter.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 17/08/22.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
