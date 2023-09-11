//
//  LoginView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("logo").resizable().scaledToFill().frame(width: 100, height: 120).padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24) {
                    InputField(text: $email, title: "Email address", placeHolder: "name@gmail.com")
                        .textInputAutocapitalization(.never)
                    
                    InputField(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                // sign in button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.forward")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.top, 24)
                
                
                Spacer()
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
                
                // sign up button
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(viewModel.alertItem!.title), message: Text(viewModel.alertItem!.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
