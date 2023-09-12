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
    @StateObject var homeVM = HomeViewModel()
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
                
                Section("Recipes"){
                    Button {
                        homeVM.getRecipeList()
                    
                    } label: {
                        Text("Fetch recipes")
                            .foregroundColor(.blue)
                    }


                }
                ForEach(homeVM.recipes) {recipe in
                    Text(recipe.name)
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
            .onAppear {
                avatarPath = viewModel.currentUser?.avatarUrl ?? ""
                homeVM.getRecipeList()
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
