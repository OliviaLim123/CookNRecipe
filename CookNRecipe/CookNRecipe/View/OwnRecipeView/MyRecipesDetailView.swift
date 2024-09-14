//
//  MyRecipesView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct MyRecipesDetailView: View {
    @EnvironmentObject var ownRecipeVM: OwnRecipeViewModel
    var recipe: CustomOwnRecipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.center)
                    .padding()
                if let imageData = recipe.image, let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 200, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding()
                }
                
                Text(recipe.description)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                Text("Ingredients")
                    .font(.headline)
                    .foregroundStyle(.pink)
                    .padding(.horizontal, 20)
                Text(recipe.ingredients)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                Text("Instruction")
                    .font(.headline)
                    .foregroundStyle(.pink)
                    .padding(.horizontal,20)
                Text(recipe.instructions)
                    .padding(.horizontal,20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.leading)
        }
    }
}

#Preview {
    MyRecipesDetailView(recipe: CustomOwnRecipe(
        name: "Spaghetti Bolognese",
        image: nil,
        description: "A delicious Italian pasta dish with a rich and flavorful meat sauce.",
        ingredients: """
        - 200g Spaghetti
        - 100g Ground Beef
        - 1 Onion, chopped
        - 2 Garlic cloves, minced
        - 400g Canned tomatoes
        - 2 tbsp Olive oil
        - Salt and pepper to taste
        """,
        instructions: """
        1. Cook the spaghetti in boiling salted water according to package instructions.
        2. Heat olive oil in a pan and sauté onions and garlic until soft.
        3. Add ground beef and cook until browned.
        4. Pour in canned tomatoes, season with salt and pepper, and simmer for 20 minutes.
        5. Toss the spaghetti with the sauce and serve hot.
        """,
        datePublished: "September 14, 2024"))
        .environmentObject(OwnRecipeViewModel())
}
