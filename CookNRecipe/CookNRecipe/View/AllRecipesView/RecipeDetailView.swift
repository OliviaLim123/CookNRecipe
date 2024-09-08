//
//  RecipeDetailView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var recipeVM: RecipeViewModel = RecipeViewModel()
    var recipe: Recipe
    var body: some View {
        ScrollView {
            if let recipeDetails = recipeVM.recipe {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: recipeDetails.image ?? "")){ image in
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
                    
                    
                }
            }

        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

//#Preview {
//    RecipeDetailView(recipe: Recipe.all[0])
//}
