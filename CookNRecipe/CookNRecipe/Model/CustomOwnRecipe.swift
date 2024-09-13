//
//  OwnRecipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

// MARK: A custom recipe model that represents the user-created recipe
struct CustomOwnRecipe: Identifiable, Hashable {
    
    // Properites of CustomOwnRecipe
    let id = UUID()
    let name: String
    let image: Data?
    let description: String
    let ingredients: String
    let instructions: String
    let datePublished: String 
}
