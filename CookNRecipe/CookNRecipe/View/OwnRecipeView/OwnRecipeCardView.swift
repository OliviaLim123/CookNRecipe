//
//  OwnRecipeCardView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct OwnRecipeCardView: View {
//    @ObservedObject private var recipeVM: RecipeViewModel
    var recipe: CustomOwnRecipe
    
    var body: some View {
        VStack {
            if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                Image (uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom){
                        Text(recipe.name)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3, x:0, y:0)
                            .frame(maxWidth: 136)
//                            .padding()
                        
                    }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom){
                        Text(recipe.name)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3, x:0, y:0)
                            .frame(maxWidth: 136)
//                            .padding()
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
  OwnRecipeCardView(recipe: CustomOwnRecipe(
    name: "Mock Recipe",
    image: nil,
    description: "example",
    ingredients: "Testing",
    instructions: "hello",
    category: Category.main.rawValue,
    datePublished: ""))
}
