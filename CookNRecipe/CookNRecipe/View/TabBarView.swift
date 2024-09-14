//
//  TabBarView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

// MARK: A struct representing a tab bar navigation interface for the application
struct TabBarView: View {
    
    var body: some View {
        TabView {
            // First Tab: Searching the recipe by ingredient
            SearchRecipeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            // Second Tab: Creating own recipe
            CreateRecipeView()
                .environmentObject(OwnRecipeViewModel())
                .tabItem {
                    Label("Create", systemImage: "plus.square.fill")
                }
            // Third Tab: Collection of saved recipe
            SavedRecipeView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            // Forth Tab: Managing the user profile account
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
