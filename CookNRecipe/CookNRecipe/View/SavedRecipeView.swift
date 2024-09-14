//
//  SavedRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import CoreData
import SwiftUI

struct SavedRecipeView: View {
    @State private var savedRecipes: [SavedRecipe] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Saved Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("\(savedRecipes.count) \(savedRecipes.count > 1 ? "recipes" : "recipe")")
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.7)
                    
                    Spacer()
                }
                
                if savedRecipes.isEmpty {
                    Text("No saved recipes")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)], spacing: 10) {
                            ForEach(savedRecipes, id: \.id) { recipe in
                                // Use NavigationLink to RecipeDetailView
                                NavigationLink(destination: RecipeDetailView(recipeId: Int(recipe.id))) {
                                    // Utilize the RecipeCardView to display saved recipes
                                    RecipeCardView(recipe: SavedRecipeModel(recipe: recipe))
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                savedRecipes = PersistenceController.shared.fetchSavedRecipes()
            }
        }
    }
}
