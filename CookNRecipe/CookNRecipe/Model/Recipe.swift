//
//  Recipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

struct Recipe: Identifiable, Codable {
//    var id = UUID()
//    let name: String
//    let url: String
//    let image: String?
//    let description: String
//    let author: String
//    let ingredients: [String]
//    let method: [String]
//    
//    enum CodingKeys: String, CodingKey {
//           case name = "Name"
//           case url = "url"
//           case image = "image"
//           case description = "Description"
//           case author = "Author"
//           case ingredients = "Ingredients"
//           case method = "Method"
//       }
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    let ingredients: [Ingredient]
    let instructions: [InstructionWrapper]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case ingredients = "extendedIngredients"
        case instructions = "analyzedInstructions"
    }
}
//mock sample of recipe 
extension Recipe{
    static let mockRecipe = Recipe(
            id: 1,
            title: "Creamy Carrot Soup",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98892/Creamy-Carrot-Soup-for-Wordpress-360x720-c.jpg",
            readyInMinutes: 25,
            servings: 4,
            summary: "This bold-hued soup is perfectly sweet and seriously comforting.",
            ingredients: [
                Ingredient(id: 1, name: "Carrot", amount: 10, unit: "pounds"),
                Ingredient(id: 2, name: "Garlic", amount: 4, unit: "cloves")
            ],
            instructions: [
                InstructionWrapper(steps: [
                    Instruction(number: 1, step: "Cover the cashews with 1/2 cup hot water."),
                    Instruction(number: 2, step: "Let soak for 20 minutes.")
                ])
            ]
        )
}
struct Ingredient: Codable {
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
