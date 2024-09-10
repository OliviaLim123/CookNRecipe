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
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [InstructionWrapper]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case extendedIngredients, analyzedInstructions
    }
//    init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            id = try container.decode(Int.self, forKey: .id)
//            title = try container.decode(String.self, forKey: .title)
//            image = try? container.decodeIfPresent(String.self, forKey: .image) // Safe decoding
//            readyInMinutes = try? container.decodeIfPresent(Int.self, forKey: .readyInMinutes)
//            servings = try? container.decodeIfPresent(Int.self, forKey: .servings)
//            summary = try? container.decodeIfPresent(String.self, forKey: .summary)
//            extendedIngredients = try? container.decodeIfPresent([Ingredient].self, forKey: .extendedIngredients) // Handle missing ingredients
//            analyzedInstructions = try? container.decodeIfPresent([InstructionWrapper].self, forKey: .analyzedInstructions)
//        }
}
//struct Ingredient: Identifiable, Codable {
//    let id: Int
//    let name: String
//    let amount: Double
//    let unit: String? 
//}
//struct InstructionWrapper: Codable {
//    let steps: [Instruction]
//}
//struct Instruction: Codable {
//    let number: Int
//    let step: String
//}

struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [InstructionWrapper]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case extendedIngredients, analyzedInstructions
    }
}

struct Ingredient: Codable, Identifiable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
}

struct InstructionWrapper: Codable {
    let name: String?
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
}
