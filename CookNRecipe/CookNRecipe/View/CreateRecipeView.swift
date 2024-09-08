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
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                        ForEach(ownRecipeVM.myRecipes) { recipe in
                            NavigationLink(destination: MyRecipesDetailView(recipe: recipe)) {
                                OwnRecipeCardView(recipe: recipe)
                            }
                        }
                    }
                    .padding(.top)
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
        }
    }
}

#Preview {
    CreateRecipeView()
        .environmentObject(OwnRecipeViewModel())
}
