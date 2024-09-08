//
//  TabBarView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Label("Catalogue", systemImage: "book.pages.fill")
                }
            SearchRecipeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            CreateRecipeView()
                .environmentObject(OwnRecipeViewModel())
                .tabItem {
                    Label("Create", systemImage: "plus.square.fill")
                }
            SavedRecipeView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            ProfileView()
                .environmentObject(AuthViewModel())
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}
