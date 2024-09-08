//
//  RecipeListView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct RecipeListView: View {
//    @StateObject var recipeVM: RecipeViewModel = RecipeViewModel()
    var recipes: [Recipe]
    
    var body: some View {
        VStack {
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "recipes" : "recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                    ForEach(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
//            recipeVM.fetchRecipes(query: "asian")
        }
        .padding(.horizontal)
    }
    
//    private func fetchRecipes() {
//            recipeVM.fetchRecipes(query: "asian") // Example query, you can change this as needed
//            
//            // Update the recipes state with the fetched data
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                recipes = recipeVM.recipes // Update the state after fetching
//            }
//        }
}


#Preview {
    ScrollView {
        RecipeListView(recipes: Recipe.all)
    }
}
