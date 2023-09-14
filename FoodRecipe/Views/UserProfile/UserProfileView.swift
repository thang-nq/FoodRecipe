//
//  UserProfileView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfileView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarPath: String = ""
    @State private var avatarViewRefresh: Bool = false
    @State private var newRecipePhoto: PhotosPickerItem? = nil
    @State private var selectedRecipePhotoData: Image? = nil
    @StateObject var homeVM = RecipeViewModel.shared
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        if user.avatarUrl.isEmpty {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                        } else {
                            UserAvatar(imagePathName: $avatarPath)
                                .frame(width: 72, height: 72)
                                .id(avatarViewRefresh)
                        }
                        
                        
                        VStack (alignment:.leading, spacing: 4) {
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        Label("Select a photo", systemImage: "photo.fill")
                    }
                }
                
                Section("Account"){
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                    
                }
                
                
                Section("New recipe") {
                    PhotosPicker(selection: $newRecipePhoto, photoLibrary: .shared()) {
                        Label("Recipe image", systemImage: "photo.fill")
                    }
                    

                }
                
                Button {
                    Task{
                        try await RecipeManager.shared.createNewRecipe(recipe: Recipe(name: "Vegan recipe", creatorID: user.id, intro: "This is a healthy and easy to make dish", tags: ["Fruit", "Vegan"]), backgroundImage: newRecipePhoto)
                        // Reset state
                        newRecipePhoto = nil
                        selectedRecipePhotoData = nil
                    }
                } label: {
                    Text("Create new recipe")
                        .foregroundColor(.blue)
                }
                
                if let selectedRecipePhotoData = selectedRecipePhotoData {
                    selectedRecipePhotoData
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                }
                
                Section("Filtered recipes") {
                    Button {
                        Task {
//                            try await RecipeManager.shared.getFilteredRecipe()
                        }
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
                    }
                    ForEach(homeVM.filteredRecipes) {recipe in
                        Text(recipe.name)
                        Text("RecipeID - \(recipe.id!)")
                        Text("CreatorID - \(recipe.creatorID)")
                        Text("Intro - \(recipe.intro)")
                        FirebaseImageView(imagePathName: recipe.backgroundURL)
                            .frame(width: 100, height: 100)
                        

                    }
                }
                
                Section("My Recipes List"){
                    Button {
                        Task {
                            try await homeVM.getUserCreatedRecipeList(userID: user.id)
                        }
                    } label: {
                        Text("Fetch recipes")
                            .foregroundColor(.red)
                    }


                    
                    
                    
                    ForEach(homeVM.myRecipeList) {recipe in
                        Text(recipe.name)
                        Text("RecipeID - \(recipe.id!)")
                        Text("CreatorID - \(recipe.creatorID)")
                        Text("Intro - \(recipe.intro)")
                        FirebaseImageView(imagePathName: recipe.backgroundURL)
                            .frame(width: 100, height: 100)
                        
                        Button {
                            Task {
                                try await RecipeManager.shared.deleteRecipe(recipeID: recipe.id!)
                            }
                        } label: {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                    }
                    
                }
                
            }
            .onChange(of: selectedPhoto, perform: { newValue in
                if let newValue {
                    Task {
                        avatarPath = try await viewModel.uploadAvatar(data: newValue)
                        avatarViewRefresh.toggle()
                    }
                }
                
            })
            .onChange(of: newRecipePhoto, perform: { newValue in
                if newValue != nil {
                    Task {
                        if let data = try await newRecipePhoto?.loadTransferable(type: Image.self) {
                            selectedRecipePhotoData = data
                        }
                    }
                }
                
            })
            .onAppear {
                avatarPath = viewModel.currentUser?.avatarUrl ?? ""
                Task {
                    await homeVM.getRecipeList()
                    try await homeVM.getUserCreatedRecipeList(userID: user.id)
                }
                
                
                
            }
            
            
            
            
        }
        
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//            .environmentObject(AuthViewModel())
//    }
//}
