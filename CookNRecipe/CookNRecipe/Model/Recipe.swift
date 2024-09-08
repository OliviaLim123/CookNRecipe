//
//  Recipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    let extendedIngredients: [Ingredient]
    let analyzedInstructions: [InstructionWrapper]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case extendedIngredients, analyzedInstructions
    }
}
struct Ingredient: Identifiable, Codable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String? 
}
struct InstructionWrapper: Codable {
    let steps: [Instruction]
}
struct Instruction: Codable {
    let number: Int
    let step: String
}
