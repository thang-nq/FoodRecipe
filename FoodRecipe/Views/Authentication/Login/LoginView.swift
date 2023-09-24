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

struct LoginView: View {
    
    // Access the AuthViewModel from the environment
    @EnvironmentObject var viewModel: AuthViewModel
    
    // State variable to control the availability of the submit button
    @State private var submitButton = true
    
    // Create an observed object for managing input fields
    @ObservedObject var inputFieldManager = InputFieldManager()
    
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
            
                loginForm
                    .padding(.top, 12)
                    .accessibilityLabel("Login form")
                
                loginButton
                    .accessibilityLabel("Login button")
                
                faceIDLoginButton
                    .padding()
                Spacer()
                
                bottomNavigation
                    .accessibilityLabel("Navigation sign up")

            }
            .overlay(
                ZStack {
                    if viewModel.showingAlert {
                        // Show an alert popup if triggered by the view model
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: popUpIcon , title: viewModel.alertItem!.title, content: viewModel.alertItem!.message, iconColor: popUpIconColor ,didClose: {viewModel.showingAlert = false})
                    }
                }
            )
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
            InputField(text: $inputFieldManager.emailInput, title: "Email address", placeHolder: "name@gmail.com")
                .textInputAutocapitalization(.never)
            
            InputField(text: $inputFieldManager.passwordInput, title: "Password", placeHolder: "Enter your password", isSecureField: true)
        }
    }
    
    // MARK: LOGIN BUTTON UI
    var loginButton: some View {
        
        Button(action:{Task {try await viewModel.signIn(withEmail: inputFieldManager.emailInput, password: inputFieldManager.passwordInput)}})
        {
            Text("Login")
                .font(Font.custom.ButtonText)
                .frame(width: 350, height: 50)
                .contentShape(Rectangle())
        }
        .foregroundColor(Color.theme.DarkBlueInstance)
        .background(inputFieldManager.isValidLogin() ? Color.theme.LightGray: Color.theme.Orange)
        .cornerRadius(8)
        .disabled(inputFieldManager.isValidLogin())

    }
    
    var faceIDLoginButton: some View {
        Button {
            Task {
                _ = await viewModel.faceIDAuth()
            }
        } label: {
            Label("Login with Face ID", systemImage: "faceid")
                .font(.custom("ZillaSlab-SemiBoldItalic", size: 20))
        }
    }
    
    //MARK: BOTTOM NAVIGATION UI
    
    var bottomNavigation: some View {
        VStack {
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(Color.theme.Blue)
                    .font(Font.custom.ContentItalic)
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Sign up")
                        .foregroundColor(Color.theme.Blue)
                        .font(Font.custom.ContentBold)

                }
            }.padding(8)
            
            
            HStack {
                Text("Forgot your password?")
                    .foregroundColor(Color.theme.Blue)
                    .font(Font.custom.ContentItalic)
                
                NavigationLink {
                    ForgetPasswordView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Reset password")
                        .foregroundColor(Color.theme.Blue)
                        .font(Font.custom.ContentBold)

                }
            }
        }

        
        
        

    }
}
