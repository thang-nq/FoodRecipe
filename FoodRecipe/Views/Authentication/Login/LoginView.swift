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
        
        // MARK: MAIN LAYOUT
        NavigationStack {
            
            VStack {
                
                appLogo
                    .padding(.top, 10)
                    .accessibilityLabel("App logo")
            
                loginForm
                    .padding(.top, 12)
                    .accessibilityLabel("Login form")
                
                loginButton
                    .accessibilityLabel("Login button")
                
                Spacer()
                
                bottomNavigation
                    .accessibilityLabel("Navigation sign up")

        
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
            .environmentObject(AuthViewModel())
    }
}


private extension LoginView {
    
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
    var loginForm: some View {
        VStack(spacing: 24) {
            InputField(text: $email, title: "Email address", placeHolder: "name@gmail.com")
                .textInputAutocapitalization(.never)
            
            InputField(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
        }
    }
    
    // MARK: LOGIN BUTTON UI
    var loginButton: some View {
        Button {
            Task {
                try await viewModel.signIn(withEmail: email, password: password)
            }
        } label: {
            HStack {
                Text("Login")
                    .font(.custom("ZillaSlab-Bold", size: 24))
            }
            .foregroundColor(Color.theme.White)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color.theme.Orange)
        .cornerRadius(12)
        .padding(.top, 24)
    }
    
    //MARK: BOTTOM NAVIGATION UI
    
    var bottomNavigation: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundColor(Color.theme.Blue)
                .font(.custom("ZillaSlab-LightItalic", size: 16))
            
            NavigationLink {
                SignupView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Sign up")
                    .foregroundColor(Color.theme.Blue)
                    .font(.custom("ZillaSlab-SemiBold", size: 16))
            }
        }

    }
}
