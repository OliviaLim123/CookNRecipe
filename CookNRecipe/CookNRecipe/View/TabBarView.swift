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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchRecipeView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            CreateRecipeView()
                .tabItem {
                    Label("Create", systemImage: "plus.square.fill")
                }
            SavedRecipeView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            ProfileView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .environmentObject(AuthViewModel())
        }
    }
}

#Preview {
    TabBarView()
}
