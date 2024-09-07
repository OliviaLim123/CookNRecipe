//
//  ContentView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                TabBarView() // if there is the user before, go back to the profile
            } else {
                LoginView() // if it is not log in yet, go to the login view
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
