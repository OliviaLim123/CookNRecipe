//
//  SearchRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

//List all the recipes
struct SearchRecipeView: View {
    @StateObject var recipeVM = RecipeViewModel()
    @State private var selectedIngredients: [String] = []
    @State private var ingredientInput: String = ""
    @State private var navigateToResults = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("Search Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.leading)
                Text("Based on the ingredients you have at home!")
                    .font(.title3)
                HStack {
                    TextField("Add an ingredient", text: $ingredientInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !ingredientInput.isEmpty {
                            selectedIngredients.append(ingredientInput)
                            ingredientInput = ""
                        }
                    }) {
                        Text("Add")
                            .padding(.horizontal)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                List {
                    ForEach(selectedIngredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete { indexSet in
                        selectedIngredients.remove(atOffsets: indexSet)
                    }
                }
                
                Spacer()
                Button(action: {
                    recipeVM.fetchRecipesByIngredient(ingredients: selectedIngredients)
                    navigateToResults = true
                }) {
                    Text("Search Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
                .fullScreenCover(isPresented: $navigateToResults) {
                   RecipeListView(recipeVM: recipeVM)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchRecipeView()
}
