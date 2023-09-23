//
//  UserEditSheet.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 22/09/2023.
//

import SwiftUI
import PhotosUI


struct EditPasswordSheet: View {
    
    // Access the AuthViewModel from the environment
    @EnvironmentObject var viewModel: AuthViewModel
    // Access the isDark mode setting using AppStorage
    @AppStorage("isDarkMode") var isDark = false
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    var body: some View {
        ZStack {
            // Apply a dark overlay if isDark mode is enabled
            if isDark {
                Color("DarkGray").opacity(0.1).ignoresSafeArea(.all)
            }
            VStack{
                changePWForm
            }
        }
        .background(Color.theme.White)
        .overlay(
            ZStack {
                if showPopUp {
                    // Display a popup view with specified content
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                }
            }
        )
    }
}

struct UserEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditPasswordSheet()
            .environmentObject(AuthViewModel())
    }
}


private extension EditPasswordSheet {
    
    // Define a view for the password change form
    var changePWForm: some View {
        VStack {
            Text("Change password")
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.Heading)
            
            // Input field for current password
            InputField(text: $viewModel.oldPW, title: "Current password", placeHolder: "Type your current pass", isSecureField: true)
            
            // Input field for new password
            InputField(text: $viewModel.updatePW, title: "New password", placeHolder: "Type your new pass", isSecureField: true)
            
            // Input field to confirm new password
            InputField(text: $viewModel.confirmUpdatePW, title: "Confirm new password", placeHolder: "Re-type your new pass", isSecureField: true)
            
            // Button to update the password
            Button(action:{
                Task {
                    do {
                        // Attempt to change the password
                        try await viewModel.changePassword(oldPassword: viewModel.oldPW, newPassword: viewModel.updatePW)
                                // Show a success popup
                                showPopUp = true
                                popUpIcon = "checkmark.icloud.fill"
                                popUptitle = "Updated Successfully"
                                popUpContent = "Your new password have been updated, please use new password for next login"
                                popUpIconColor = Color.theme.GreenInstance
                        
                    } catch {
                        // Show an error popup if password change fails
                        showPopUp = true
                        popUpIcon = "person.crop.circle.badge.exclamationmark.fill"
                        popUptitle = "Error"
                        popUpContent = "\(error.localizedDescription)"
                        popUpIconColor = Color.theme.RedInstance
                                
                        print(error.localizedDescription)
                    }
                }
            })
            {
                Text("Update password")
                    .font(Font.custom.ButtonText)
                    .frame(width: 350, height: 50)
                    .contentShape(Rectangle())
            }
            .foregroundColor(Color.theme.DarkBlueInstance)
            .background(viewModel.isValidUpdatePW() ? Color.theme.LightGray: Color.theme.Orange)
            .cornerRadius(8)
            .padding(8)
            .disabled(viewModel.isValidUpdatePW())
        }
    }
    
}
