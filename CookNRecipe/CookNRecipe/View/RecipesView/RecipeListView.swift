//
//  HomeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

//List all the recipes
struct RecipeListView: View {
    @ObservedObject var recipeVM = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("Recipe Results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text("\(recipeVM.recipes.count) \(recipeVM.recipes.count > 1 ? "recipes" : "recipe")")
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.7)
                    
                    Spacer()
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 5)], spacing: 10) {
                        ForEach(recipeVM.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView( recipeId: recipe.id,recipeVM: recipeVM)) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeListView()
}
