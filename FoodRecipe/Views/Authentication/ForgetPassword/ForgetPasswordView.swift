//
//  LoginView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    // Access the AuthViewModel from the environment
    @EnvironmentObject var viewModel: AuthViewModel
    
    // State variable to control the availability of the submit button
    @State private var submitButton = true
    
    // Create an observed object for managing input fields
    @ObservedObject var inputFieldManager = InputFieldManager()
    
    // Access the dismiss key
    @Environment(\.dismiss) var dismiss
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = "person.crop.circle.badge.exclamationmark.fill"
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.RedInstance
    
    var body: some View {
        
        // MARK: MAIN LAYOUT
        NavigationStack {
            VStack {
                appLogo
                    .padding(.top, 10)
                    .accessibilityLabel("App logo")
            
                resetForm
                    .padding(.top, 12)
                    .accessibilityLabel("Forget password form")
                
                sendPWResetEmail
                    .accessibilityLabel("Submit button")
                
                Spacer()
                
                bottomNavigation
                    .accessibilityLabel("Navigation login")

            }
            .overlay(
                ZStack {
                    if showPopUp {
                        // Show an alert popup if triggered by the view model
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                    }
                }
            )
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .environmentObject(AuthViewModel())
//    }
//}


private extension ForgetPasswordView {
    
    // MARK: LOGO AND SLOGAN UI
    var appLogo: some View {
        VStack(spacing: 10) {
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 200)
            
            Text("From Kitchen Novice to Culinary Expert")
                .font(.custom("ZillaSlab-BoldItalic", size: 24))
                .foregroundColor(Color.theme.DarkGray)
        }
    }
    
    // MARK: LOGIN FORM UI
    var resetForm: some View {
        VStack(spacing: 24) {
            InputField(text: $inputFieldManager.emailInput, title: "Email address", placeHolder: "name@gmail.com")
                .textInputAutocapitalization(.never)
        }
    }
    
    // MARK: LOGIN BUTTON UI
    var sendPWResetEmail: some View {
        
        Button(action:{
            Task {
                do {
                    try await viewModel.sendResetPasswordEmail(withEmail: inputFieldManager.emailInput)
                    showPopUp = true
                    popUpIcon = "envelope.fill"
                    popUptitle = "Reset password email sent"
                    popUpContent = "Check your email for instruction to reset your password"
                    popUpIconColor = Color.theme.GreenInstance
                } catch {
                    showPopUp = true
                    popUpIcon = "envelope.fill"
                    popUptitle = "Reset password error"
                    popUpContent = error.localizedDescription
                    popUpIconColor = Color.theme.RedInstance
                }

            }
        })
        {
            Text("Submit")
                .font(Font.custom.ButtonText)
                .frame(width: 350, height: 50)
                .contentShape(Rectangle())
        }
        .foregroundColor(Color.theme.DarkBlueInstance)
        .background(inputFieldManager.isValidResetPW() ? Color.theme.LightGray: Color.theme.Orange)
        .cornerRadius(8)
        .disabled(inputFieldManager.isValidResetPW())

    }

    
    //MARK: BOTTOM NAVIGATION UI
    
    var bottomNavigation: some View {
        HStack {
            Text("Already reset the password?")
                .foregroundColor(Color.theme.Blue)
                .font(Font.custom.ContentItalic)
            
            Button {
                dismiss()
            } label: {
                Text("Login")
                    .foregroundColor(Color.theme.Blue)
                    .font(Font.custom.ContentBold)

            }
        }

    }
}
