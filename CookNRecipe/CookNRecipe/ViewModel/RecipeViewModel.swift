//
//  RecipeAPI.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation
class RecipeViewModel: ObservableObject {
//    @Published var recipes: [Recipe]
    
//    init(filename: String = "recipes.json") {
//        let decoder = JSONDecoder()
//        guard let url = Bundle.main.url(forResource: filename, withExtension: nil),
//              let data = try? Data(contentsOf: url),
//              let recipes = try? decoder.decode([Recipe].self, from: data)
//        else {
//            self.recipes = []
//            return
//        }
//        self.recipes = recipes
//    }
    @Published var recipes: [Recipe] = []
    
    private let recipeURL = "https://api.spoonacular.com/recipes"
    private let apiKey = "73be4e5f26f147f29ff3ff564f3e920f"
    
    
    func fetchRecipes(query: String) {
        let urlString = "\(recipeURL)/complexSearch?query=\(query)&apiKey=\(apiKey)&addRecipeInformation=true&number=10"
        performRequest(urlString: urlString)
    }
    func fetchRecipesByIngredient(ingredient: String) {
        let urlString = "\(recipeURL)/findByIngredients?ingredients=\(ingredient)&apiKey=\(apiKey)&number=10"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
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
    }
    func parseJSON(recipeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeSearchResponse.self, from: recipeData)
            DispatchQueue.main.async {
                self.recipes = decodedData.results
                print("Successfully fetched recipes: \(self.recipes.count)")
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}
struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}
