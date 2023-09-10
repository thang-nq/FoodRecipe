//
//  SignupView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Image("logo").resizable().scaledToFill().frame(width: 100, height: 120).padding(.vertical, 32)
            
            
            // form fields
            VStack(spacing: 24) {
                InputField(text: $email, title: "Email address", placeHolder: "name@gmail.com")
                    .textInputAutocapitalization(.never)
                
                InputField(text: $fullName, title: "Full name", placeHolder: "Enter your name")
                
                
                InputField(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                
                InputField(text: $confirmPassword, title: "Password", placeHolder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "person")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(12)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already has an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 16))
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
