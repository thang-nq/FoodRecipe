//
//  UserProfileMockView.swift
//  FoodRecipe
//
//  Created by Man Pham on 19/09/2023.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfileMockView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarViewRefresh: Bool = false
    @State private var inputText: String = ""
    @State private var oldPassword: String = ""
    @State private var password: String = ""
    @StateObject var homeVM = HomeViewModel()
    @StateObject var userProfileViewModel = UserProfileViewModel.shared
    // MARK: change to environment object when demo
    //    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    var body: some View {
        NavigationView {
            ScrollView {
                if let currentUser = viewModel.currentUser {
                    top(currentUser: currentUser)
                    myRecipes(recipeList: userProfileViewModel.recipeList)
                }
                Spacer()
            }
            .padding(16)
            .onAppear {
                Task {
                    await userProfileViewModel.getUserCreatedRecipe()
                }
            }
        }
        .onChange(of: selectedPhoto, perform: { newValue in
                if let newValue {
                    
                    // CALL POP UP
                    showPopUp = true
                    popUpIcon = "checkmark.message.fill"
                    popUptitle = "Upload avatar success"
                    popUpContent = "If you have any more requests or need further assistance, feel free to ask!, If you have any more requests or need further assistance, feel free to ask!"
                    popUpIconColor = Color.theme.GreenInstance
                    
                    Task {
                        try await viewModel.uploadAvatar(data: newValue)
                        await viewModel.fetchUser()
                        avatarViewRefresh.toggle()
                    }
                }
            })
    }
}

struct UserProfileMockView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileMockView()
    }
}

private extension UserProfileMockView {
    // MARK: USER AVATAR
    func emptyAvatar(initials: String) -> some View {
        Text(initials)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 72, height: 72)
            .background(Color(.systemGray3))
            .clipShape(Circle())
    }
    func top(currentUser: User) -> some View {
        VStack {
            SectionTitleView(title: "User Profile Settings")
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(currentUser.fullName)
                            .font(.custom.Heading)
                            .foregroundColor(Color.theme.Black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text(currentUser.email)
                            .font(.custom.Content)
                            .foregroundColor(Color.theme.Orange)
                            .underline()
                        Text(currentUser.initials).font(.custom.Content)
                        //                            .foregroundColor()
                    }.padding(0)
                    Spacer()
                    
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        if currentUser.avatarUrl.isEmpty {
                            emptyAvatar(initials: currentUser.initials)
                        } else {
                            UserAvatar(imagePathName: currentUser.avatarUrl)
                                .frame(width: 60, height: 60)
                                .id(avatarViewRefresh)
                            
                        }
                    }
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 60, height: 60)
//                        .background(
//
//                            FirebaseImage(imagePathName: currentUser.avatarUrl)
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 60, height: 60)
//                                .clipped()
//
//
//                        )
//                        .cornerRadius(60)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 60)
//                                .inset(by: -2.5)
//                                .stroke(.white, lineWidth: 5)
//                        )
                }
                
            }
            .padding(.vertical, 16)
            .background(Color.theme.White)
            .shadow(color: Color.theme.Black.opacity(0.1), radius: 0, x: 0, y: -1)
            .shadow(color: Color.theme.Black.opacity(0.1), radius: 0, x: 0, y: 1)
        }
    }
    
    func myRecipes(recipeList: [Recipe]) -> some View {
        VStack {
            HStack {
                SectionTitleView(title: "My Recipes")
                NavigationLink(destination: CreateRecipeView()) {
                    Text("Create recipe")
                        .font(.custom.SubContent)
                        .foregroundColor(Color.theme.Orange).underline()
                }
            }
            ForEach(recipeList){ recipe in
                MyRecipeCard(recipe: recipe)
            }
//            Grid {
//                ForEach(Array(stride(from: 0, to: recipeList.count, by: 2)), id: \.self) { index in
//                    GridRow {
//                        CompactRecipeCard(recipe: recipeList[index])
//                        if(index + 1 < recipeList.count) {
//                            CompactRecipeCard(recipe: recipeList[index+1])
//                        }
//                    }
//                }
//            }
        }
    }
}
