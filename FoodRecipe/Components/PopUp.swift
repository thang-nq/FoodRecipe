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

struct PopUp: View {
    
    //MARK: POP UP VARAIBALES
    
    var iconName: String // Icon name string
    var title: String // Title string
    var content: String // Content string
    var iconColor: Color // Icon color
    let didClose: () -> Void // Closure for handling close action
    
    var body: some View {
        
        // close pop-up attribute
        VStack(spacing: 10) {
            icon
                .foregroundColor(iconColor)
            contentWrapper
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .frame(width: 350, height: 250)
        .background(backGroundStyle)
        .overlay(alignment: .topTrailing) {
            closeButton // Display the close button
        }
    }
}

struct PopUp_Previews: PreviewProvider {
    static var previews: some View {
        PopUp(iconName: "hare.fill", title: "Rabbit notification", content: "If you have any more requests or need further assistance, feel free to ask!, If you have any more requests or need further assistance, feel free to ask!", iconColor: Color.theme.BlueInstance ,didClose: {})
    }
}


private extension PopUp {
    
    // MARK: ICON UI
    var icon: some View {
        // Display an image with the specified icon name and style
        Image(systemName: iconName)
            .symbolVariant(.circle.fill)
            .font(.system(size: 50,
                          weight: .bold,
                          design: .rounded
                         )
            )
    }
    
    
    // MARK: CLOSE BUTTON
    var closeButton: some View {
        Button(){
            didClose()  // Call the closure when the button is tapped
        } label: {
            // Display an image with an "x" icon for closing
            Image(systemName: "xmark.circle")
                    .symbolVariant(.circle.fill)
                    .font(.system(size:30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.theme.BlackInstance)
                    .padding(8)
        }
    }
    
    // MARK: POPUP STYLE
    var backGroundStyle: some View {
        // Apply rounded corners and a shadow to create a popup style
        RoundedCorners(color: Color.theme.DarkWhiteInstance, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: .black.opacity(0.5) ,radius: 30)
    }
    
    // MARK: CONTENT VIEW
    var contentWrapper: some View {
        // Vertical stack to arrange title and content text
        VStack(spacing: 10){
            Text(title)
                .font(.custom("ZillaSlab-Bold", size: 26)) // Set the title font
            Text(content)
                .font(.custom("ZillaSlab-SemiBold", size: 20))  // Set the content font
        }
        .foregroundColor(Color.theme.DarkBlueInstance) // Set text color
    }
}
