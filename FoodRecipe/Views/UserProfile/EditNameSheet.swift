//
//  EditNameSheet.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 23/09/2023.
//

import SwiftUI

struct EditNameSheet: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("isDarkMode") var isDark = false
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    var body: some View {
        ZStack{
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
    
    var changeNameForm: some View {
        VStack {
            
            Text("Edit User name")
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.Heading)
            
            InputField(text: $viewModel.updateName, title: "User name", placeHolder: "Type your new user name")
            
            
            Button(action:{
                
                Task {
                    do {
                        try await viewModel.updateUserName(name: viewModel.updateName)
                        showPopUp = true
                        popUpIcon = "checkmark.icloud.fill"
                        popUptitle = "Updated Successfully"
                        popUpContent = "Your new user name have been updated"
                        popUpIconColor = Color.theme.GreenInstance
                    } catch {
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
