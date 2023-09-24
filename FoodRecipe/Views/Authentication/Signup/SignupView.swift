/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 10/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct SignupView: View {
        
    // Create an observed object for managing input fields
    @ObservedObject var inputFieldManager = InputFieldManager()
    
    // Access the AuthViewModel from the environment
    @EnvironmentObject var viewModel: AuthViewModel
    
    // Access the dismiss environment key
    @Environment(\.dismiss) var dismiss
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.RedInstance
    
    var body: some View {
        // MARK: MAIN LAYOUT
        VStack{
            appLogo
                .accessibilityLabel("App logo")
            
            signUpForm
                .accessibilityLabel("Sign up form")
                .padding(.horizontal, 10)
            
            registerBtn
            Spacer()
            bottomNavigation
        }
        .overlay(
            ZStack {
                if viewModel.showingAlert {
                    // Show an alert popup if triggered by the view model
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: "person.crop.circle.badge.exclamationmark.fill" , title: viewModel.alertItem!.title, content: viewModel.alertItem!.message, iconColor: popUpIconColor ,didClose: {viewModel.showingAlert = false})
                }
            }
        )
        .overlay(
            ZStack {
                if showPopUp {
                    // Show a custom popup if needed
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                }
            }
        )
        
    }
    
//  MARK: PRINT FONTS (DEV LOG ONLY)
//    init() {
//        for familyName in UIFont.familyNames {
//            print(familyName)
//
//            for fontName in UIFont.fontNames(forFamilyName: familyName){
//                print("-- \(fontName)")
//            }
//        }
//    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(AuthViewModel())
    }
}


private extension SignupView {
    
    // MARK: LOGO UI
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
    
    // MARK: FORM UI
    var signUpForm: some View {
        
        VStack(spacing: 24) {
            
            Text("Create an account")
                .foregroundColor(Color.theme.DarkBlue)
                .font(.custom("ZillaSlab-BoldItalic", size: 30))
            
            VStack{
                InputField(text: $inputFieldManager.nameInput, title: "Name", placeHolder: "Enter your name")
                InputField(text: $inputFieldManager.emailInput, title: "E-mail", placeHolder: "name@gmail.com")
                    .textInputAutocapitalization(.never)
                InputField(text: $inputFieldManager.passwordInput, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                InputField(text: $inputFieldManager.repeatPWInput, title: "Repeat Password", placeHolder: "Confirm your password", isSecureField: true)
            }
            
        }
    }
    
    // MARK: SUBMIT BUTTON UI
    var registerBtn: some View {
        
        Button(action:{
            if inputFieldManager.repeatNotMatch() {
                showPopUp = true
                popUpIcon = "checkmark.circle.badge.xmark.fill"
                popUptitle = "Invalid confirm password"
                popUpContent = "Your confirm password does not match"
            }
            else
            {
                Task {try await viewModel.createUser(withEmail: inputFieldManager.emailInput, password: inputFieldManager.passwordInput, fullName: inputFieldManager.nameInput)}
            }
        })
        {
            Text("Register")
                .font(Font.custom.ButtonText)
                .frame(width: 380, height: 50)
                .contentShape(Rectangle())
        }
        .foregroundColor(Color.theme.DarkBlueInstance)
        .background(inputFieldManager.isValidRegister() ? Color.theme.LightGray: Color.theme.Orange)
        .cornerRadius(8)
        .disabled(inputFieldManager.isValidRegister())
        
    }
    
    // MARK: BOTTOM NAVIGATION UI
    var bottomNavigation: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Color.theme.Blue)
                .font(Font.custom.ContentItalic)
            
            Button {
                dismiss()
            } label: {
                Text("Log in")
                    .foregroundColor(Color.theme.Blue)
                    .font(Font.custom.ContentBold)
            }
        }
    }
    
}
