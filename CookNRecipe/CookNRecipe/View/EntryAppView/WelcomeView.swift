//
//  WelcomeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 3/9/2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                Text("Welcome to ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.systemPink))
                    .padding(.top, 20)
                Text("Cook N Recipe App!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.systemPink))
                
                LottieView(name: Constants.cookAnimation, loopMode: .loop, animationSpeed: 0.7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text("Let's exploring new recipes, searching food based on your ingredient, creating your own recipe, and learning how to cook step by step! ")
                    .font(.subheadline)
                    .padding(.bottom,40)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: ContentView().environmentObject(viewModel).navigationBarBackButtonHidden(true)) {
                    HStack {
                        Text("START COOKING")
                            .fontWeight(.semibold)
                        Image(systemName: "fork.knife")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPink))
                .cornerRadius(10)
                .padding(.bottom, 50)
//                Button {
//                    navigateToContentView = true
//                } label: {
//                    HStack {
//                        Text("START COOKING")
//                            .fontWeight(.semibold)
//                        Image(systemName: "fork.knife")
//                    }
//                    .foregroundStyle(.white)
//                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
//                }
//                .background(Color(.systemPink))
//                .cornerRadius(10)
//                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthViewModel())
}
