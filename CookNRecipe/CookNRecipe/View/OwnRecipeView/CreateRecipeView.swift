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
    @State private var selectedRecipe: CustomOwnRecipe? = nil
    @State private var showDeleteConfirmation = false
    
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
                        .padding(.bottom, 5)
                    
                    Spacer()
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 10)], spacing: 10) {
                        ForEach(ownRecipeVM.myRecipes) { recipe in
                            NavigationLink(destination: MyRecipesDetailView(recipe: recipe)) {
                                OwnRecipeCardView(recipe: recipe)
                                    .frame(width: 160)
                                    .contextMenu {
                                    Button(action: {
                                        selectedRecipe = recipe
                                        showDeleteConfirmation = true
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                        }
                                    }
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
                .padding(.horizontal, 20)
                .navigationViewStyle(.stack)
                .fullScreenCover(isPresented: $showAddRecipe){
                    AddRecipeView()
                        .environmentObject(ownRecipeVM)
                }
                HStack(alignment: .center) {
                    Image(systemName: "trash")
                        .padding(.leading, 20)
                        .foregroundStyle(.pink)
                    Text("Please press and hold to remove the recipe")
                        .font(.subheadline)
                        .foregroundStyle(.pink)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onAppear {
                ownRecipeVM.fetchRecipes() // Ensure recipes are fetched when view appears
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Recipe"),
                    message: Text("Are you sure you want to delete this recipe?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let recipeToDelete = selectedRecipe {
                            ownRecipeVM.deleteRecipe(recipe: recipeToDelete)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    CreateRecipeView()
        .environmentObject(OwnRecipeViewModel())
}
