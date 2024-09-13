//
//  CreateRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

struct CreateRecipeView: View {
    @State private var showAddRecipe = false
    @EnvironmentObject var ownRecipeVM : OwnRecipeViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("My Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                HStack {
                    Text("\(ownRecipeVM.myRecipes.count) \(ownRecipeVM.myRecipes.count > 1 ? "recipes" : "recipe")")
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.7)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)], spacing: 10) {
                        ForEach(ownRecipeVM.myRecipes) { recipe in
                            NavigationLink(destination: MyRecipesDetailView(recipe: recipe)) {
                                OwnRecipeCardView(recipe: recipe)
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 20)
                }
                Spacer()
                Button {
                    showAddRecipe = true
                } label: {
                    HStack {
                        Text("ADD YOUR RECIPE")
                            .fontWeight(.semibold)
                        Image(systemName: "doc.badge.plus")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPink))
                .cornerRadius(10)
                .padding(.top, 24)
                .padding(.horizontal, 20)
                .navigationViewStyle(.stack)
                .fullScreenCover(isPresented: $showAddRecipe){
                    AddRecipeView()
                        .environmentObject(ownRecipeVM)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onAppear {
                ownRecipeVM.fetchRecipes() // Ensure recipes are fetched when view appears
            }
        }
    }
}

#Preview {
    CreateRecipeView()
        .environmentObject(OwnRecipeViewModel())
}
