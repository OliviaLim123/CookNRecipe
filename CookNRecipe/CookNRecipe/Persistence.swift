//
//  Persistance.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 13/9/2024.
//

import CoreData

// MARK: a stuct that responsible for managing Core Data persistence
struct PersistenceController {
    
    // The shared instance of 'PersistenceController' for the whole app
    static let shared = PersistenceController()
    // The container to hold the persistent store
    let container: NSPersistentContainer
    
    // Initialises the persistence controller and load the persistence store
    init() {
        container = NSPersistentContainer(name: "DataCookNRecipe")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    // A property to access the view context of the persistent container
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    // METHOD: Save a recipe id, title, and image to Core Data
    func saveRecipe(recipe: Recipe) {
        let savedRecipe = SavedRecipe(context: context)
        savedRecipe.id = Int64(recipe.id)
        savedRecipe.title = recipe.title
        savedRecipe.image = recipe.image
        
        // If the recipe has ingredients, format them as a comma-separated string
        if let ingredients = recipe.extendedIngredients {
            let ingredientsString = ingredients.map { "\($0.amount.clean) \($0.unit) \($0.name)" }.joined(separator: ", ")
            savedRecipe.ingredients = ingredientsString
        }
        
        // If the recipe has instructions, format them as a step-by-step string
        if let instructions = recipe.analyzedInstructions {
            let instructionsString = instructions.flatMap { $0.steps.map { "\($0.number). \($0.step)" } }.joined(separator: "\n")
            savedRecipe.instructions = instructionsString
        }
        
        // Try to save the context and persist the recipe
        do {
            try context.save()
        } catch {
            print("Error saving recipe: \(error)")
        }
    }

    // METHOD: Check if a recipe with the id is already saved in Core Data
    func isRecipeSaved(recipeId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        // Filter the recipe by id
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeId)
        // Limit the fetch to 1
        fetchRequest.fetchLimit = 1
        
        // Try to count the results for the fetch request
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if recipe is saved: \(error)")
            return false
        }
    }

    // METHOD: Remove a saved recipe with id from Core Data
    func removeRecipe(recipeId: Int) {
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        // Filter the recipe by id
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeId)

        // Fetch the recipe and delete it if found
        do {
            let recipes = try context.fetch(fetchRequest)
            if let recipeToDelete = recipes.first {
                context.delete(recipeToDelete)
                // Save the context after the deletion process
                try context.save()
            }
        } catch {
            print("Error deleting recipe: \(error)")
        }
    }

    // METHOD: Fetches all saved recipes from Core Data
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
