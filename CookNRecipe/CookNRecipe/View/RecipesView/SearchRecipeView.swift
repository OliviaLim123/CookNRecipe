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
        NavigationStack {
            VStack(alignment: .leading){
                Text("What's in your fridge?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                Text("Enter the ingredient you have at home! ")
                    .font(.title3)
                    .padding(.horizontal)
                HStack {
                    TextField("Add an ingredient", text: $ingredientInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        if !ingredientInput.isEmpty {
                            selectedIngredients.append(ingredientInput)
                            ingredientInput = ""
                        }
                    } label: {
                        HStack {
                            Text("Add")
                                .fontWeight(.semibold)
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 30)
                    }
                    .background(Color(.systemPink))
                    .cornerRadius(10)
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
                Button {
                    recipeVM.fetchRecipesByIngredient(ingredients: selectedIngredients)
                    navigateToResults = true
                } label: {
                    Text("Search Recipes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 40)
                .navigationDestination(isPresented: $navigateToResults) {
                    RecipeListView(recipeVM: recipeVM)
                }
            }
        }
    }
}

#Preview {
    SearchRecipeView()
}
