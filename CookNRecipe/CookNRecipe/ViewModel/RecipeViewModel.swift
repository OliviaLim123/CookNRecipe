//
//  RecipeAPI.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipe: Recipe?
    @Published var isLoading = true
    
    private let recipeURL = "https://api.spoonacular.com/recipes"
    private let apiKey = "6fad4f0efbc848e3a9c4f359a6623cbc"
    
    
    func fetchRecipes() {
        guard let url = URL(string:"\(recipeURL)/random?number=50&apiKey=\(apiKey)")  else {
            print("Invalid URL")
            return
        }
        performRequest(url: url)
    }
//    func fetchRecipesByCuisine(cuisine: String) {
//        guard let url = URL(string:"\(recipeURL)/complexSearch?apiKey=\(apiKey)&query=\(cuisine)&number=50")  else {
//            print("Invalid URL")
//            return
//        }
//        performRequest(url: url)
//    }
    func fetchRecipesByIngredient(ingredients: [String]) {
        let _ = ingredients.joined(separator: ",")
        let urlString = "\(recipeURL)/findByIngredients?ingredients=\(ingredients)&apiKey=\(apiKey)&number=20"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Recipe].self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
    
    func performRequest(url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let safeData = data {
                if let jsonString = String(data: safeData, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
                self.parseJSON(recipeData: safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(recipeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeSearchResponse.self, from: recipeData)
            
            DispatchQueue.main.async {
                self.recipes = decodedData.recipes
                print("Successfully fetched recipes: \(self.recipes.count)")
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
    
    func fetchRecipeDetails(recipeId: Int) async {
        guard let url = URL(string:"https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print(json)
            }
            let recipeDetails = try JSONDecoder().decode(Recipe.self, from: data)
            DispatchQueue.main.async {
                self.selectedRecipe = recipeDetails
            }
        } catch {
            print("Error fetching recipe details: \(error)")
        }
    }
//    func performRequestDetails(url: URL) {
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                }
//                return
//            }
//            
//            if let safeData = data {
//                self.parseJSONDetails(recipeData: safeData)
//            }
//        }
//        task.resume()
//    }
//    func parseJSONDetails(recipeData: Data) {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(RandomRecipeResponse.self, from: recipeData)
//            
//            DispatchQueue.main.async {
//                self.recipe = decodedData.recipes.first
//                self.isLoading = false
//                print("Successfully fetched recipes: \(self.recipes.count)")
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//            print("Error parsing JSON: \(error)")
//        }
//    }
}

struct RecipeSearchResponse: Codable {
    let recipes: [Recipe]
}
struct RandomRecipeResponse: Codable {
    let recipes: [Recipe]
}
