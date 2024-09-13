//
//  SavedRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

//import SwiftUI
import CoreData
//
//struct SavedRecipeView: View {
//    // Fetching saved recipes from Core Data
//    @FetchRequest(
//        entity: SavedRecipe.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \SavedRecipe.title, ascending: true)]
//    ) var savedRecipes: FetchedResults<SavedRecipe> // Fetched results from Core Data
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                Text("My Saved Recipes")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundStyle(.pink)
//                    .multilineTextAlignment(.leading)
//                
//                HStack {
//                    Text("\(savedRecipes.count) \(savedRecipes.count > 1 ? "recipes" : "recipe")")
//                        .font(.headline)
//                        .fontWeight(.medium)
//                        .opacity(0.7)
//                    
//                    Spacer()
//                }
//                
//                if savedRecipes.isEmpty {
//                    Text("No saved recipes")
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 5)], spacing: 10) {
//                            ForEach(savedRecipes) { savedRecipe in
//                                let savedRecipeModel = SavedRecipeModel(recipe: savedRecipe) // Map Core Data model to UI-friendly model
//                                
//                                // Navigate to the detail view when tapping the card
//                                NavigationLink(destination: RecipeDetailView(recipeId: savedRecipeModel.id)) {
//                                    SavedRecipeCardView(recipe: savedRecipeModel)
//                                }
//                            }
//                        }
//                        .padding(.top)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}

import SwiftUI


struct SavedRecipeView: View {
    @State private var savedRecipes: [SavedRecipe] = []

    var body: some View {
        NavigationView {
            List(savedRecipes, id: \.id) { recipe in
                VStack(alignment: .leading) {
                    Text(recipe.title ?? "Unknown Title")
                        .font(.headline)
                    if let ingredients = recipe.ingredients {
                        Text(ingredients)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
            }
            .navigationTitle("My Saved Recipes")
            .onAppear {
                savedRecipes = PersistenceController.shared.fetchSavedRecipes()
            }
        }
    }
}

#Preview {
    SavedRecipeView()
}
