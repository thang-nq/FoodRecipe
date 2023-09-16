//
//  SignupView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct SignupView: View {
        
    @ObservedObject var inputFieldManager = InputFieldManager()    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // MARK: MAIN LAYOUT
        VStack() {
            appLogo
                .accessibilityLabel("App logo")
            
            signUpForm
                .accessibilityLabel("Sign up form")
                .padding(.horizontal, 10)
            
            registerBtn
            Spacer()
            bottomNavigation
        }
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
            
            // MARK: SAMPLE FONT
            // COLOR SELECTION PREVIEW IN ASSEST COLOR FOLDER
            Text("From Kitchen Novice to Culinary Expert")
//                .font(.custom("ZillaSlab-Regular", size: 24))
//                .font(.custom("ZillaSlab-Italic", size: 24))
//                .font(.custom("ZillaSlab-Light", size: 24))
//                .font(.custom("ZillaSlab-LightItalic", size: 24))
//                .font(.custom("ZillaSlab-Medium", size: 24))
//                .font(.custom("ZillaSlab-MediumItalic", size: 24))
//                .font(.custom("ZillaSlab-SemiBold", size: 24))
//                .font(.custom("ZillaSlab-SemiBoldItalic", size: 24))
//                .font(.custom("ZillaSlab-Bold", size: 24))
                .font(.custom("ZillaSlab-BoldItalic", size: 24))
            // MARK: SAMPLE COLOR
//                .foregroundColor(Color.theme.Black)
//                .foregroundColor(Color.theme.Blue)
//                .foregroundColor(Color.theme.DarkBlue)
                .foregroundColor(Color.theme.DarkGray)
//                .foregroundColor(Color.theme.DarkWhite)
//                .foregroundColor(Color.theme.Gray)
//                .foregroundColor(Color.theme.LightBlue)
//                .foregroundColor(Color.theme.LightGray)
//                .foregroundColor(Color.theme.Orange)
//                .foregroundColor(Color.theme.White)
//                .foregroundColor(Color.theme.LightOrange)
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
            Task {try await viewModel.createUser(withEmail: inputFieldManager.emailInput, password: inputFieldManager.passwordInput, fullName: inputFieldManager.nameInput
            )}}){
            Text("Register")
                .font(.custom("ZillaSlab-SemiBoldItalic", size: 20))
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
                .font(.custom("ZillaSlab-LightItalic", size: 16))
            
            Button {
                dismiss()
            } label: {
                Text("Log in")
                    .foregroundColor(Color.theme.Blue)
                    .font(.custom("ZillaSlab-SemiBold", size: 16))
            }
        }
    }
    
}
