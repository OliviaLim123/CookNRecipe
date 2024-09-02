//
//  CookNRecipeApp.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import SwiftUI
import Firebase

@main
struct CookNRecipeApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(viewModel)
//                //initialise only in one place and can be used accross multiple screens
            LaunchScreenView()
                .environmentObject(viewModel)
        }
    }
}
