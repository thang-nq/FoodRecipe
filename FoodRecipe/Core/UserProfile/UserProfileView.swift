//
//  UserProfileView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var imagePath: String = ""
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
                            UserAvatar(imagePath: imagePath)
                                .frame(width: 72, height: 72)
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
                        Text("Select a photo")
                        
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
            }
            .onChange(of: selectedPhoto, perform: { newValue in
                if let newValue {
                    Task {
                        imagePath = try await viewModel.uploadAvatar(data: newValue)
                    }

                }
            })
            .onAppear {
                imagePath = viewModel.currentUser!.avatarUrl
            }
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
