//
//  RecipeDetailView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipeId: Int
    @ObservedObject var recipeVM = RecipeViewModel() // Observing the ViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let recipeDetail = recipeVM.selectedRecipe {
                    Text(recipeDetail.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.pink)
                    
                    if let imageUrl = recipeDetail.image {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .center)
                                .foregroundColor(.white.opacity(0.7))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                        .frame(height: 200)
                        .cornerRadius(10)

                    }
                        
                            Text("Ingredients")
                                .font(.headline)
                                .foregroundStyle(.pink)
                                .padding(.top)
                            
                            if let ingredients = recipeDetail.extendedIngredients {
                                ForEach(ingredients) { ingredient in
                                    Text("\(ingredient.amount, specifier: "%.2f") \(ingredient.unit) \(ingredient.name)")
                                        .padding(.vertical, 2)
                                }
                            }
                            
                            Text("Instructions")
                                .font(.headline)
                                .foregroundStyle(.pink)
                            
                            // Instructions
                            if let instructions = recipeDetail.analyzedInstructions {
                                ForEach(instructions, id: \.name) { instructionWrapper in
                                    ForEach(instructionWrapper.steps, id: \.number) { step in
                                        Text("\(step.number). \(step.step)")
                                            .padding(.vertical, 2)
                                    }
                                }
                            }else {
                                Text("No instructions available.")
                            }
                } else {
                    VStack {
                        ProgressView("Loading Recipe Details...")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear {
                // Trigger fetching details when the view appears
                Task {
                    
                    await recipeVM.fetchRecipeDetails(recipeId:recipeId)
                    
                }
            }
        }
    }
}
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}

//#Preview {
//    RecipeDetailView(recipeId: 1)
//}
