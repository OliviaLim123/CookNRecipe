//
//  RecipeAPI.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation

// MARK: A viewModel to manage fetching and storing recipe data from Spooncular API
class RecipeViewModel: ObservableObject {
    
    // Published properties of RecipeViewModel
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipe: Recipe?
    @Published var isLoading = true
    
    // URL and my API key for Spooncular API (free subscription - 150points/day)
    private let recipeURL = "https://api.spoonacular.com/recipes"
    private let apiKey = "6fad4f0efbc848e3a9c4f359a6623cbc"
    
    // METHOD: API call to fetch recipes by ingredients
    func fetchRecipesByIngredient(ingredients: [String], completion: @escaping () -> Void) {
        // Join the ingredients into a comma-separated string for API request
        let _ = ingredients.joined(separator: ",")
        // URL for API request which will provide 20 lists of recipe
        let urlString = "\(recipeURL)/findByIngredients?ingredients=\(ingredients)&apiKey=\(apiKey)&number=20"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion()
            return
        }
        
        // Fetch the recipes with URL session
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Try to decode the response data into an array of 'Recipe' objects
                    let decodedResponse = try JSONDecoder().decode([Recipe].self, from: data)
                    // Update the 'recipes' array
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse
                        completion()
                    }
                } catch {
                    // Handle any errors during decoding
                    print("Error decoding data: \(error)")
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } else if let error = error {
                // Handle any network errors
                print("HTTP Request Failed \(error)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume() // Start the data task
    }
    
    // METHOD: API call to fetch detailed information about a specific recipe using the id
    func fetchRecipeDetails(recipeId: Int) async {
        // Construct and check the URL is valid
        guard let url = URL(string:"\(recipeURL)/\(recipeId)/information?apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        do {
            // Perform any asynchronous data fetch
            let (data, _) = try await URLSession.shared.data(from: url)
            print("API Call successful, raw data: \(data)")
            
            // Try to decode the fetched data into a 'Recipe' object
            let recipeDetails = try JSONDecoder().decode(Recipe.self, from: data)
            print("Decoded recipe details: \(recipeDetails)") 
            
            // Update the 'selectedRecipe' and 'isLoading' properties
            DispatchQueue.main.async {
                self.selectedRecipe = recipeDetails
                self.isLoading = false
            }
        } catch {
            // Handle any erros that occur during the fetch or decoding
            print("Error fetching recipe details: \(error)")
            // Set the loading to false
            DispatchQueue.main.async {
                self.isLoading = false 
            }
        }
    }
}
