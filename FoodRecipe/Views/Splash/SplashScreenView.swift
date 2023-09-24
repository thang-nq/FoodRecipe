/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI

struct SplashScreenView: View {
    
    @State private var logoSize = 0.4 // Initial logo size
    @State private var texOpacity = 0.5 // Initial text opacity
    @State private var isActive = false // A state to track if the splash screen should transition to ContentView
    @State private var logoRotationAngle: Angle = .degrees(0) // Initial logo rotation angle
    @StateObject private var authVM = AuthViewModel()  // Initialize an authentication view model
    
    var body: some View {
        if isActive {
            // If isActive is true, transition to the ContentView
            ContentView()
                .environmentObject(authVM) // Pass the authentication view model to the ContentView
            
        } else {
            VStack(spacing: 10) {
                
                Image("logo") // Display an image with the name "logo"
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 200)
                    .scaleEffect(logoSize) // Scale the logo image based on the logoSize state
                    .rotationEffect(logoRotationAngle) // Rotate the logo image based on the logoRotationAngle state
                
                Text("From Kitchen Novice to Culinary Expert")
                    .font(.custom("ZillaSlab-BoldItalic", size: 24))
                    .foregroundColor(Color.theme.DarkGray)
                    .opacity(texOpacity) // Set the text opacity
            }
            .onAppear{
                // Apply animations when the view appears
                withAnimation(.easeIn(duration: 1.5)){
                    self.logoSize = 1
                }
                withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                    self.texOpacity = 1.0
                }
                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0)) {
                    self.logoRotationAngle = .degrees(360)
                }
            }
            .onAppear{
                // Set a delay before transitioning to ContentView
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = true // Activate the transition to ContentView
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
