//
//  MyRecipesView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct MyRecipesView: View {
    @EnvironmentObject var ownRecipeVM: OwnRecipeViewModel
    var recipe: OwnRecipe
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: recipe.image)){ image in
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
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
                VStack(alignment: .leading, spacing: 30){
                    Text(recipe.description)
                    VStack(alignment: .leading, spacing: 20){
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundStyle(.pink)
                        Text(recipe.ingredients)
                    }
                    VStack(alignment: .leading, spacing: 20){
                        Text("Instruction")
                            .font(.headline)
                            .foregroundStyle(.pink)
                        Text(recipe.instructions)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.leading)
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    MyRecipesView(recipe: OwnRecipe(
        name: "Mock Recipe",
        image: "",
        description: "example",
        ingredients: "Testing",
        instructions: "hello",
        category: Category.main.rawValue,
        datePublished: ""))
        .environmentObject(OwnRecipeViewModel())
}
