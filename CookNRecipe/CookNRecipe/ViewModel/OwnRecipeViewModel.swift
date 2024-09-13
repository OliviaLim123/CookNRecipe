//
//  OwnRecipeViewModel.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

//import Foundation
//
//class OwnRecipeViewModel: ObservableObject {
//    @Published var myRecipes: [CustomOwnRecipe] = []
//    
//    func addRecipe(recipe: CustomOwnRecipe){
//        myRecipes.append(recipe)
//    }
//    func deleteRecipe(at indexSet: IndexSet) {
//        myRecipes.remove(atOffsets: indexSet)
//    }
//}
import SwiftUI
import CoreData

class OwnRecipeViewModel: ObservableObject {
    @Published var myRecipes: [CustomOwnRecipe] = []

    private var viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchRecipes()  // Fetch recipes as soon as the view model is initialized
    }

    // Method to add a new recipe
    func addRecipe(recipe: CustomOwnRecipe) {
        let newRecipe = OwnedRecipe(context: viewContext)
        newRecipe.name = recipe.name
        newRecipe.image = recipe.image
        newRecipe.recipeDescription = recipe.description
        newRecipe.ingredients = recipe.ingredients
        newRecipe.instructions = recipe.instructions
        newRecipe.datePublished = recipe.datePublished
        
        saveContext()
        fetchRecipes()
    }

    // Fetch recipes from Core Data
    func fetchRecipes() {
        let request: NSFetchRequest<OwnedRecipe> = OwnedRecipe.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
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

    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteRecipe(recipe: CustomOwnRecipe) {
            let request: NSFetchRequest<OwnedRecipe> = OwnedRecipe.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", recipe.name)
            
            do {
                let result = try viewContext.fetch(request)
                if let objectToDelete = result.first {
                    viewContext.delete(objectToDelete)
                    saveContext()
                    fetchRecipes()  // Refresh the recipes list after deletion
                }
            } catch {
                print("Failed to delete recipe: \(error)")
            }
        }

}
