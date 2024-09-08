//
//  OwnRecipeViewModel.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

class OwnRecipeViewModel: ObservableObject {
    @Published var myRecipes: [OwnRecipe] = []
    
    func addRecipe(recipe: OwnRecipe){
        myRecipes.append(recipe)
    }
}
