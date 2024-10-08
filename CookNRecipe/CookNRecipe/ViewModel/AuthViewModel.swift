//
//  AuthViewModel.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 1/9/2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor // publishing back to the main
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? { //firebase user
        didSet {
            self.isLoggedIn = userSession != nil // Automatically update isLoggedIn when userSession changes
        }
    }
    @Published var currentUser: User? //our user
    @Published var isLoggedIn: Bool = false {
        didSet {
            objectWillChange.send() // manually trigger the view 
        }
    }
    @Published var loginErrorMessage: String?
    
    init() {
        checkUserSession()
        self.userSession = Auth.auth().currentUser // if there is the user log in, it will stay in the profile view
        self.isLoggedIn = userSession != nil
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.isLoggedIn = true
            self.loginErrorMessage = nil
            await fetchUser() // without this, the profile view will be blank
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            self.loginErrorMessage = "Sorry, your account is invalid. Please Sign Up to continue!"
            self.isLoggedIn = false
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            //create user from the firebase
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            //create user model with the result from the firebase
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            //upload the data into the firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out user on back end
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes current user data model
            self.isLoggedIn = false
        } catch {
            print("DEBUG: Failed to sign out error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        do {
            try await Firestore.firestore().collection("users").document(uid).delete()
            try await user.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async { // from the firebase account
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func checkUserSession() {
        if let currentUser = Auth.auth().currentUser {
            print ("DEBUG: user is logged in")
            self.userSession = currentUser
            self.isLoggedIn = true
        } else {
            print("DEBUG: No user logged in")
            self.isLoggedIn = false
        }
    }
}
