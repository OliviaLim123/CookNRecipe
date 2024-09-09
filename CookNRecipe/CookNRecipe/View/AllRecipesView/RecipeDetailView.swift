//
//  RecipeDetailView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @StateObject var recipeVM = RecipeViewModel() // Observing the ViewModel
       @State private var isLoading = true // State to track loading
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: recipe.image ?? "")){ image in
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
                }
                .frame(height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                VStack(spacing: 30) {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.pink)
                        .multilineTextAlignment(.center)
                    VStack(alignment: .leading){
                        // HTML Summary
                        if let summary = recipe.summary {
                            HTMLTextView(htmlContent: summary)
                        } else {
                            Text("No summary available.")
                                .font(.body)
                        }
                                         
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundStyle(.pink)
                        // Ingredients
                        if let ingredients = recipe.extendedIngredients {
                            
                            ForEach(ingredients, id: \.id) { ingredient in
                                Text("• \(ingredient.amount.clean) \(ingredient.unit ?? "") \(ingredient.name)")
                                    .font(.body)
                            }
                        }else {
                            Text("No ingredients available.")
                        }
                        
                        Text("Instructions")
                            .font(.headline)
                            .foregroundStyle(.pink)
                        
                        // Instructions
                        if let instructions = recipe.analyzedInstructions?.first?.steps {
                                                    
                            ForEach(instructions, id: \.number) { step in
                                Text("\(step.number). \(step.step)")
                                .font(.body)
                            }
                        }else {
                            Text("No instructions available.")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.leading)
                }
            }
        }
        .onAppear {
                    // Trigger fetching details when the view appears
                    Task {
                        await fetchRecipeDetails()
                    }
                }
        .ignoresSafeArea(.container, edges: .top)
        
    }
    private func fetchRecipeDetails() async {
           // Assuming recipeVM has a method to fetch details asynchronously
           await recipeVM.fetchRecipeDetails(recipeId: recipe.id)
           isLoading = false // Turn off the loading state once data is fetched
       }
}
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%2f", self)
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(
        id: 1,
        title: "Example",
        image: "",
        readyInMinutes: 20,
        servings: 2,
        summary: "<h1>Test Content</h1><p>This is a paragraph of text.</p>",
        extendedIngredients: [
            Ingredient(id: 1, name: "Carrot", amount: 3.0, unit: "pcs"),
            Ingredient(id: 2, name: "Garlic", amount: 2.0, unit: "cloves")
        ],
        analyzedInstructions: [
            InstructionWrapper(steps: [
                Instruction(number: 1, step: "Chop the carrots."),
                Instruction(number: 2, step: "Boil them for 10 minutes.")
            ])
        ]))
}
