//
//  SavedRecipe.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 14/9/2024.
//

import Foundation

// MARK: A struct representing a saved Recipe from persistent storage
struct SavedRecipeModel: RecipeRepresentable {
    
    // Properties of saved recipe model
    let id: Int
    let title: String
    let image: String?
    
    // Initialises a saved recipe model from the SavedRecipe entity in the data core 
    init(recipe: SavedRecipe) {
        self.id = Int(recipe.id)
        self.title = recipe.title ?? "Unknown Title"
        self.image = recipe.image
    }
}
