//
//  HomeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

//List all the recipes
struct HomeView: View {
    @StateObject var recipeVM = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            Text("Home View")
        }
    }
}

#Preview {
    HomeView()
}
