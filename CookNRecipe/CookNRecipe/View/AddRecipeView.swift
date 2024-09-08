//
//  AddRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI

struct AddRecipeView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")){
                }
                Section(header: Text("Category")){
                    
                }
                Section(header: Text("Description")){
                    
                }
                Section(header: Text("Ingredients")){
                    
                }
                Section(header: Text("Instructions")){
                    
                }
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    AddRecipeView()
}
