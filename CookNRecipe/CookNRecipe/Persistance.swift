//
//  Persistance.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 13/9/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "DataCookNRecipe") // Make sure this matches your Core Data model
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    // Save a recipe
    func saveRecipe(recipe: Recipe) {
        let savedRecipe = SavedRecipe(context: context)
        savedRecipe.id = Int64(recipe.id)
        savedRecipe.title = recipe.title
        savedRecipe.image = recipe.image
        
        // Unwrapping ingredients if they exist
        if let ingredients = recipe.extendedIngredients {
            let ingredientsString = ingredients.map { "\($0.amount.clean) \($0.unit) \($0.name)" }.joined(separator: ", ")
            savedRecipe.ingredients = ingredientsString
        }
        
        // Unwrapping instructions if they exist
        if let instructions = recipe.analyzedInstructions {
            let instructionsString = instructions.flatMap { $0.steps.map { "\($0.number). \($0.step)" } }.joined(separator: "\n")
            savedRecipe.instructions = instructionsString
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving recipe: \(error)")
        }
    }


    // Check if a recipe is saved
    func isRecipeSaved(recipeId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeId)
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if recipe is saved: \(error)")
            return false
        }
    }

    // Remove a saved recipe
    func removeRecipe(recipeId: Int) {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeId)

        do {
            let recipes = try context.fetch(fetchRequest)
            if let recipeToDelete = recipes.first {
                context.delete(recipeToDelete)
                try context.save()
            }
        } catch {
            print("Error deleting recipe: \(error)")
        }
    }

    // Fetch saved recipes
    func fetchSavedRecipes() -> [SavedRecipe] {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching saved recipes: \(error)")
            return []
        }
    }
}
