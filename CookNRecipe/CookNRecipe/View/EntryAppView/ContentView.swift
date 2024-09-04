//
//  ContentView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import SwiftUI

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
        .onAppear {
            viewModel.isLoggedIn = viewModel.userSession != nil
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
