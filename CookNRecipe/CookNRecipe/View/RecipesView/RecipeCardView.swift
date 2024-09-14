//
//  RecipeCardView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct RecipeCardView<T: RecipeRepresentable>: View {
    var recipe: T
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.image ?? "")){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom){
                        Text(recipe.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3, x:0, y:0)
                            .frame(maxWidth: 136)
                            .padding()
                        
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom){
                        Text(recipe.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3, x:0, y:0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
            }
        }
        .frame(width: 160, height: 217)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

#Preview {
    RecipeCardView(recipe: Recipe(id: 1,
                                  title: "Spaghetti Carbonara",
                                  image: "",
                                  readyInMinutes: 30,
                                  servings: 4,
                                  summary: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper",
                                  extendedIngredients: [
                                    Ingredient(id: 1, name: "Spaghetti", amount: 200, unit: "g"),
                                    Ingredient(id: 2, name: "Pancetta", amount: 100, unit: "g"),
                                    Ingredient(id: 3, name: "Eggs", amount: 2, unit: "pcs"),
                                    Ingredient(id: 4, name: "Parmesan Cheese", amount: 50, unit: "g"),
                                    Ingredient(id: 5, name: "Black Pepper", amount: 1, unit: "tsp"),
                                    Ingredient(id: 6, name: "Salt", amount: 0.5, unit: "tsp")
                                  ],
                                  analyzedInstructions: [
                                    InstructionWrapper(
                                        name: "Main Instructions",
                                        steps: [
                                            Step(number: 1, step: "Cook the spaghetti in salted boiling water."),
                                            Step(number: 2, step: "Fry the pancetta in a pan until crispy."),
                                            Step(number: 3, step: "Mix eggs and Parmesan in a bowl."),
                                            Step(number: 4, step: "Toss the cooked pasta with pancetta and egg mixture."),
                                            Step(number: 5, step: "Season with black pepper and serve.")
                                        ]
                                    )
                                ]
                                )
                   )
}
