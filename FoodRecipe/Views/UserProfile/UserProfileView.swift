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
//    @StateObject var homeVM = HomeViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            VStack{
                VStack {
                    // MARK: WIREFRAME USER DATA
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        if user.avatarUrl.isEmpty {
                            emptyAvatar(initials: user.initials)
                        } else {
                            UserAvatar(imagePathName: $avatarPath)
                                .id(avatarViewRefresh)
                        }
                    }
                    
                    userData(fullName: user.fullName, email: user.email)
            
                    signOutButton
                }
                
                // MARK: RECIPE WRAPPER
//                VStack {
//                    ForEach(homeVM.recipes) {recipe in
//                        Text(recipe.name)
//                    }
//                }
            }
            .overlay(
                ZStack {
                    if showPopUp {
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                    }
                }
                .opacity(showPopUp ? 1 : 0)
            )
            .onChange(of: selectedPhoto, perform: { newValue in
                if let newValue {
                    
                    // CALL POP UP
                    showPopUp = true
                    popUpIcon = "checkmark.message.fill"
                    popUptitle = "Upload avatar success"
                    popUpContent = "If you have any more requests or need further assistance, feel free to ask!, If you have any more requests or need further assistance, feel free to ask!"
                    popUpIconColor = Color.theme.GreenInstance
                    
                    Task {
                        avatarPath = try await viewModel.uploadAvatar(data: newValue)
                        avatarViewRefresh.toggle()
                    }
                }
            })
            .onAppear {
                avatarPath = viewModel.currentUser?.avatarUrl ?? ""
            }
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(AuthViewModel())
    }
}


private extension UserProfileView {
    
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
    
    // MARK: USER NAME AND EMAIL
    func userData(fullName: String, email: String) -> some View  {
        VStack (alignment:.leading, spacing: 4) {
            Text(fullName)
                .fontWeight(.semibold)
                .padding(.top, 4)
            
            Text(email)
                .font(.footnote)
                .foregroundColor(.blue)
        }
    }
        
    //MARK: LOGOUT BUTTON UI
    var signOutButton: some View {
        Button {
            viewModel.signOut()
        } label: {
            Text("Sign out")
                .foregroundColor(.red)
        }
    }
    
    
}
