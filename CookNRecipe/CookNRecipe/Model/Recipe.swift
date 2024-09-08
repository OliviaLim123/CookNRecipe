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
    let ingredients: String
    let instructions: String
//    let ingredients: [Ingredient]
//    let instructions: [InstructionWrapper]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, readyInMinutes, servings, summary
        case ingredients = "extendedIngredients"
        case instructions = "analyzedInstructions"
    }
}
//mock sample of recipe 
extension Recipe{
    static let all: [Recipe] = [
        Recipe(
            id: 1,
            title: "Creamy Carrot Soup",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98892/Creamy-Carrot-Soup-for-Wordpress-360x720-c.jpg",
            readyInMinutes: 25,
            servings: 4,
            summary: "This bold-hued soup is perfectly sweet and seriously comforting.",
            ingredients: "10 pounds of carrot \n2 cloves of Garlic \n10 gram of mushroom",
            instructions: "1. Cover the cashews with 1/2 cup of hot water \n2. Let soak for 20 minutes"
        ),
        Recipe(
            id: 2,
            title: "Spagetti Carbonara",
            image: "https://www.sipandfeast.com/wp-content/uploads/2022/09/spaghetti-carbonara-recipe-6.jpg",
            readyInMinutes: 25,
            servings: 2,
            summary: "A classic Italian Spaghetti and easy to make at home.",
            ingredients: "100 gram of Spaghetti \n100 gram of bacon \n1 block of cheese \n10 gram of Parsley",
            instructions: "1. Boil the pasta 30 mins \n2. Fry the bacons "
        )]
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
