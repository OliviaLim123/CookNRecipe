//
//  OwnRecipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case breakfast = "Breakfast"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case snack = "Snack"
    case drink = "Drink"
}

struct CustomOwnRecipe: Identifiable {
    let id = UUID()
    let name: String
    let image: Data?
    let description: String
    let ingredients: String
    let instructions: String
    let category: Category.RawValue
    let datePublished: String 
}
