//
//  LoginView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel //no need to initialise again
    
    var body: some View {
        NavigationStack {
            VStack {
                //Image
                Image("cook")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 10)
                Text("Cook N Recipe")
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                    .font(.title)
                    .padding(.bottom, 25)
                //Form Fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //Sign in button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPink))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5) //give the faded button
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                //Sign up button
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack (spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            .alert(isPresented: .constant(viewModel.loginErrorMessage != nil)){
                Alert(
                    title: Text("Login Failed"),
                    message: Text(viewModel.loginErrorMessage ?? ""),
                    dismissButton: .default(Text("OK")) {
                        viewModel.loginErrorMessage = nil
                    }
                )
            }
            
        }
    }
}

//MARK: - AuthenticationFormProtocol
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 6
    }
}

#Preview {
    LoginView()
}
