//
//  RecipeDetailFix.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 10/9/2024.
//
import SwiftUI

struct RecipeDetailFix: View {
    let recipeId: Int
    @ObservedObject var recipeVM: RecipeViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let recipeDetail = recipeVM.selectedRecipeDetail {
                    // Display title, image, etc.
                    Text(recipeDetail.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    if let imageUrl = recipeDetail.image {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                    }
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    
                    // Display ingredients
                    if let ingredients = recipeDetail.extendedIngredients {
                        ForEach(ingredients) { ingredient in
                            Text("\(ingredient.amount, specifier: "%.2f") \(ingredient.unit) \(ingredient.name)")
                                .padding(.vertical, 2)
                        }
                    }
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)
                    
                    // Display instructions
                    if let instructions = recipeDetail.analyzedInstructions {
                        ForEach(instructions, id: \.name) { instructionWrapper in
                            ForEach(instructionWrapper.steps, id: \.number) { step in
                                Text("\(step.number). \(step.step)")
                                    .padding(.vertical, 2)
                            }
                        }
                    } else {
                        Text("No instructions available")
                            .foregroundColor(.gray)
                    }
                } else {
                    ProgressView("Loading recipe details...")
                        .task {
                            await recipeVM.fetchRecipeDetails(recipeId: recipeId)
                        }
                }
            }
        }
        .padding()
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
