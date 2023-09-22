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
    @State private var showChangePasswordField: Bool = false
    @ObservedObject var inputFieldManager = InputFieldManager()
    @StateObject var homeVM = HomeViewModel()
    @StateObject var userProfileViewModel = UserProfileViewModel.shared
    @EnvironmentObject var viewModel: AuthViewModel
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    
    //MARK: TUAN'S TEST
    @State var showingPWSheet: Bool = false
    @State var showingNameSheet: Bool = false
    @AppStorage("isDarkMode") var isDark = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                if let currentUser = viewModel.currentUser {
                    
                    top(currentUser: currentUser)
                    
                    if showChangePasswordField {
                        VStack {
                            InputField(text: $viewModel.oldPW, title: "Current password", placeHolder: "Type your current pass", isSecureField: true)
                            InputField(text: $viewModel.updatePW, title: "New password", placeHolder: "Type your new pass", isSecureField: true)
                            
                            Button(action:{
                                Task {
                                    print("text")
                                    do {
                                        try await viewModel.changePassword(oldPassword: viewModel.oldPW, newPassword: viewModel.updatePW)
                                        showPopUp = true
                                        popUpIcon = "checkmark.message.fill"
                                        popUptitle = "Error"
                                        popUpContent = "Update password success"
                                        popUpIconColor = Color.theme.GreenInstance
                                        
                                    } catch {
                                        showPopUp = true
                                        popUpIcon = "checkmark.message.fill"
                                        popUptitle = "Error"
                                        popUpContent = "\(error.localizedDescription)"
                                        popUpIconColor = Color.theme.RedInstance
                                        print(error.localizedDescription)
                                    }
                                }
                                

                            }){
                                Text("Submit")
                                    .font(Font.custom.ButtonText)
                                    .frame(width: 150, height: 50)
                                    .contentShape(Rectangle())
                            }
                            .foregroundColor(Color.theme.DarkBlueInstance)
                            .background(viewModel.isValidUpdatePW() ? Color.theme.LightGray: Color.theme.Orange)
                            .cornerRadius(8)
                            .padding(8)
                            .disabled(viewModel.isValidUpdatePW())
                        }
                    }
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
        .overlay(
            ZStack {
                if showPopUp {
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                }
            }
        )
    }
}

//struct UserProfileMockView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileMockView()
//    }
//}

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
                        
                        HStack {
                            Text(currentUser.fullName)
                                .font(.custom.Heading)
                                .foregroundColor(Color.theme.Black)
                            
                            Button {
                                viewModel.updateName = ""
                                showingNameSheet.toggle()
                            } label: {
                                Image(systemName: "highlighter")
                                    .foregroundColor(Color.theme.DarkBlue)
                            }
                            .sheet(isPresented: $showingNameSheet) {
                                EditNameSheet()
                                    .presentationDetents([.medium, .large])
                                    .environment(\.colorScheme, isDark ? .dark : .light)
                            }
                            
                        }

                        Text(currentUser.email)
                            .font(.custom.Content)
                            .foregroundColor(Color.theme.Orange)
                            .underline()
                        
                        
                        HStack {
                            Button(action: {
                                viewModel.signOut()
                            }) {
                                HStack {
                                    Image(systemName: "power")
                                        .foregroundColor(Color.theme.RedInstance)
                                    Text("Log out")
                                        .font(Font.custom.SubContent)
                                        .foregroundColor(Color.theme.RedInstance)
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.theme.RedInstance, lineWidth: 2)
                                )
                            }
                            .padding(2)
                            
                            
//                            Button(action: {
//                                showChangePasswordField.toggle()
//                            }) {
//                                HStack {
//                                    Image(systemName: "lock.fill")
//                                        .foregroundColor(Color.theme.BlueInstance)
//                                    Text("Edit")
//                                        .foregroundColor(Color.theme.BlueInstance)
//                                }
//                                .padding(8)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.theme.BlueInstance, lineWidth: 2)
//                                )
//                            }
//                            .padding(2)
                            
                            Button {
                                viewModel.updatePW = ""
                                viewModel.confirmUpdatePW = ""
                                viewModel.oldPW = ""
                                showingPWSheet.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(Color.theme.BlueInstance)
                                    
                                    Text("Change password")
                                        .font(Font.custom.SubContent)
                                        .foregroundColor(Color.theme.BlueInstance)
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.theme.BlueInstance, lineWidth: 2)
                                )
                            }
                            .sheet(isPresented: $showingPWSheet) {
                                EditPasswordSheet()
                                    .presentationDetents([.medium, .large])
                                    .environment(\.colorScheme, isDark ? .dark : .light)
                            }
                            
                        }
                        

                        
                    }
                    
                    Spacer()
                    
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        if currentUser.avatarUrl.isEmpty {
                            emptyAvatar(initials: currentUser.initials)
                        } else {
                            UserAvatar(imagePathName: currentUser.avatarUrl)
                                .frame(width: 40, height: 70)
                                .id(avatarViewRefresh)
                                .padding(.horizontal, 20)
                            
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
