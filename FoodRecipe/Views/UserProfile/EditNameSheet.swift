//
//  EditNameSheet.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 23/09/2023.
//

import SwiftUI

struct EditNameSheet: View {
    
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
        ZStack{
            // Apply a dark overlay if isDark mode is enabled
            if isDark {
                Color("DarkGray").opacity(0.1).ignoresSafeArea(.all)
            }
            VStack {
                changeNameForm
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

struct EditNameSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditNameSheet()
            .environmentObject(AuthViewModel())
    }
}

private extension EditNameSheet {
    
    // Define a view for the user name change form
    var changeNameForm: some View {
        VStack {
            
            Text("Edit User name")
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.Heading)
            
            // Input field for the new user name
            InputField(text: $viewModel.updateName, title: "User name", placeHolder: "Type your new user name")
            
            // Button to update the user name
            Button(action:{
                
                Task {
                    do {
                        // Attempt to update the user name
                        try await viewModel.updateUserName(name: viewModel.updateName)
                        // Show a success popup
                        showPopUp = true
                        popUpIcon = "checkmark.icloud.fill"
                        popUptitle = "Updated Successfully"
                        popUpContent = "Your new user name have been updated"
                        popUpIconColor = Color.theme.GreenInstance
                    } catch {
                        // Show an error popup if the update fails
                        showPopUp = true
                        popUpIcon = "person.crop.circle.badge.exclamationmark.fill"
                        popUptitle = "Error"
                        popUpContent = "\(error.localizedDescription)"
                        popUpIconColor = Color.theme.RedInstance
                    }
                    
                }
            })
            {
                Text("Update user name")
                    .font(Font.custom.ButtonText)
                    .frame(width: 350, height: 50)
                    .contentShape(Rectangle())
            }
            .foregroundColor(Color.theme.DarkBlueInstance)
            .background(viewModel.isValidUpdateName() ? Color.theme.LightGray: Color.theme.Orange)
            .cornerRadius(8)
            .padding(8)
            .disabled(viewModel.isValidUpdateName())
        }
    }
    
}
