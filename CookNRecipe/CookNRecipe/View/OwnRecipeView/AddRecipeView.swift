//
//  AddRecipeView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @State private var name: String = ""
    @State private var image: UIImage? = nil
    @State private var description: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    @State private var showImagePicker: Bool = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var navigateToRecipe: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ownRecipeVM: OwnRecipeViewModel
    
    var body: some View {
        VStack {
            Text("New Recipes")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.pink)
                .multilineTextAlignment(.center)
            NavigationView {
                Form {
                    Section(header: Text("Name")){
                        TextField("Recipe Name", text: $name)
                    }
                    Section(header: Text("Image")) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        } else {
                            Text("No image selected")
                                .foregroundStyle(.gray)
                        }
                        HStack {
                            Button("Pick from Library") {
                                imageSourceType = .photoLibrary
                                showImagePicker = true
                            }
                        }

                    }
                    Section(header: Text("Description")){
                        TextEditor(text: $description)
                    }
                    Section(header: Text("Ingredients")){
                        TextEditor(text: $ingredients)
                    }
                    Section(header: Text("Instructions")){
                        TextEditor(text: $instructions)
                    }
                }
            }
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("CANCEL")
                            .fontWeight(.semibold)
                        Image(systemName: "xmark")
                    }
                    .foregroundStyle(.white)
                    .frame(width: 150, height: 48)
                }
                .background(Color(.systemPink))
                .cornerRadius(10)
                .padding(.top, 24)
                .padding(.horizontal)
                
                Button {
                    saveRecipe()
                    dismiss()  // Dismiss the form after saving
                } label: {
                    HStack {
                        Text("DONE")
                            .fontWeight(.semibold)
                        Image(systemName: "checkmark")
                    }
                    .foregroundStyle(.white)
                    .frame(width: 150, height: 48)
                }
                .background(Color(.systemPink))
                .disabled(name.isEmpty)
                .opacity(!name.isEmpty ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)

            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: imageSourceType, selectedImage: $image)
        }
        .navigationViewStyle(.stack)
    }
}

extension AddRecipeView {
    private func saveRecipe() {
        // Get the current date
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Corrected the date format
        let datePublished = dateFormatter.string(from: now)
        
        // Prepare image data
        let imageData = image?.jpegData(compressionQuality: 0.8) ?? Data()
        
        // Create a new recipe
        let recipe = CustomOwnRecipe(
            name: name,
            image: imageData,
            description: description,
            ingredients: ingredients,
            instructions: instructions,
            datePublished: datePublished
        )
        
        // Save recipe using the view model
        ownRecipeVM.addRecipe(recipe: recipe)
    }
}

#Preview {
    AddRecipeView()
        .environmentObject(OwnRecipeViewModel())
}
