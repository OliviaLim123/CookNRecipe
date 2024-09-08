//
//  SettingView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 4/9/2024.
//

import SwiftUI

struct SettingView: View {
    @State private var showProfile = false
    var body: some View {
        VStack {
            Button(action: {
                showProfile = true
            }) {
                Text("Manage Account")
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
                    .environmentObject(AuthViewModel())
                }
            }
            .navigationTitle("Settings")
            
        
    }
}

#Preview {
    SettingView()
}
