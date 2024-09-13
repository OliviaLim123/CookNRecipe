//
//  Recipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

// MARK: A protocol representing the basic properties of a recipe
protocol RecipeRepresentable {
    
    // All recipes that conform to this protocol must provide id, title, and image
    var id: Int { get }
    var title: String { get }
    var image: String? { get }
}

// MARK: A recipe struct representing a detailed recipe and conform to RecipeRepresentable protocol
struct Recipe: Identifiable, Codable, RecipeRepresentable {
    
    // Properties of Recipe model
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [InstructionWrapper]?
    
    // CodingKeys to map JSON keys to the property names in the struct
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case extendedIngredients, analyzedInstructions
    }

}

// MARK: A struct representing ingredient model in the recipe
struct Ingredient: Codable, Identifiable {
    
    // Properties of ingredient model
    let id: Int
    let name: String
    let amount: Double
    let unit: String
}

// MARK: A wrapper struct representing a set of instructions for a recipe
struct InstructionWrapper: Codable {
    
    // Properties of instruction wrapper
    let name: String?
    let steps: [Step]
}

// MARK: A struct representing a single step in a recipe's instructions
struct Step: Codable {
    
    // Properties of step struct
    let number: Int
    let step: String
}
