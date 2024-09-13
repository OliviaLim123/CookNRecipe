//
//  OwnRecipeViewModel.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI
import CoreData

// MARK: a viewModel class to manage user-created recipes
class OwnRecipeViewModel: ObservableObject {
    
    // Published property to hold the list of custom recipes
    @Published var myRecipes: [CustomOwnRecipe] = []
    // Reference to the Core Data
    private var viewContext = PersistenceController.shared.container.viewContext
    
    // Initialises the viewModel by fetching existing recipes from Core Data
    init() {
        fetchRecipes()
    }

    // METHOD: Add a new recipe to Core Data
    func addRecipe(recipe: CustomOwnRecipe) {
        let newRecipe = OwnedRecipe(context: viewContext)
        newRecipe.name = recipe.name
        newRecipe.image = recipe.image
        newRecipe.recipeDescription = recipe.description
        newRecipe.ingredients = recipe.ingredients
        newRecipe.instructions = recipe.instructions
        newRecipe.datePublished = recipe.datePublished
        
        // Save the new recipe to Core Data
        saveContext()
        // Fetch the updated list of recipes
        fetchRecipes()
    }

    // METHOD: Fetch recipes from Core Data and updates the 'myRecipes' array
    func fetchRecipes() {
        let request: NSFetchRequest<OwnedRecipe> = OwnedRecipe.fetchRequest()
        
        do {
            // Execute the fetch process
            let result = try viewContext.fetch(request)
            // Map each 'OwnedRecipe' entity to 'CustomOwnRecipe' and update the 'myRecipes' array
            myRecipes = result.map { entity in
                CustomOwnRecipe(name: entity.name ?? "",
                                image: entity.image ?? Data(),
                                description: entity.recipeDescription ?? "",
                                ingredients: entity.ingredients ?? "",
                                instructions: entity.instructions ?? "",
                                datePublished: entity.datePublished ?? "")
            }
        } catch {
            print("Failed to fetch recipes: \(error)")
        }
    }

    // METHOD: Save changes to the Core Data context
    private func saveContext() {
        // Check if there are unsaved changes
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // METHOD: Deletes a recipe from Core Data based on its name
    func deleteRecipe(recipe: CustomOwnRecipe) {
        let request: NSFetchRequest<OwnedRecipe> = OwnedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipe.name)
        
        do {
            let result = try viewContext.fetch(request)
            // If the recipe is found, delete it
            if let objectToDelete = result.first {
                // Delete the recipe from Core Data
                viewContext.delete(objectToDelete)
                // Save the context after the deletion process
                saveContext()
                // Refresh the recipes lists after deletion
                fetchRecipes()
            }
        } catch {
            print("Failed to delete recipe: \(error)")
        }
    }
}
