//
//  User.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import Foundation

// MARK: A user model for email authentication function with Firebase
struct User: Identifiable, Codable {
    
    // MARK: Properties of user model
    let id: String
    let fullName: String
    let email: String
    
    // Divide the FullName and will display it in the profile circle shape
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

// MARK: The mock user
extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Olivia Lim", email: "test@gmail.com")
}
