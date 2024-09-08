//
//  MyRecipesView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct MyRecipesDetailView: View {
    @EnvironmentObject var ownRecipeVM: OwnRecipeViewModel
    var recipe: OwnRecipe
    var body: some View {
        ScrollView {
            if let imageData = recipe.image, let uiImage = UIImage(data: imageData){
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                    .frame(height: 300)
            }
            VStack(spacing: 30) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
                VStack(alignment: .leading, spacing: 30){
                    Text(recipe.description)
                        .padding(.horizontal, 30)
                    VStack(alignment: .leading, spacing: 20){
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundStyle(.pink)
                            .padding(.horizontal, 30)
                        Text(recipe.ingredients)
                            .padding(.horizontal, 30)
                    }
                    VStack(alignment: .leading, spacing: 20){
                        Text("Instruction")
                            .font(.headline)
                            .foregroundStyle(.pink)
                            .padding(.horizontal,30)
                        Text(recipe.instructions)
                            .padding(.horizontal,30)
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
    MyRecipesDetailView(recipe: OwnRecipe(
        name: "Mock Recipe",
        image: nil,
        description: "example",
        ingredients: "Testing",
        instructions: "hello",
        category: Category.main.rawValue,
        datePublished: ""))
        .environmentObject(OwnRecipeViewModel())
}
