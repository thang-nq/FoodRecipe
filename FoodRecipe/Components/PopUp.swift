//
//  PopUp.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 13/09/2023.
//

import SwiftUI

struct PopUp: View {
    
    var iconName: String
    var title: String
    var content: String
    var iconColor : Color
    let didClose: () -> Void
    
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
            closeButton
        }
//        .transition(.move(edge: .bottom))
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
            didClose()
        } label: {
        Image(systemName: "xmark.circle")
                .symbolVariant(.circle.fill)
                .font(.system(size:30, weight: .bold, design: .rounded))
                .foregroundStyle(Color.theme.BlackInstance)
                .padding(8)
        }
    }
    
    // MARK: POPUP STYLE
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.DarkWhiteInstance, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: .black.opacity(0.5) ,radius: 30)
    }
    
    // MARK: CONTENT VIEW
    var contentWrapper: some View {
        VStack(spacing: 10){
            Text(title)
                .font(.custom("ZillaSlab-Bold", size: 26))
            Text(content)
                .font(.custom("ZillaSlab-SemiBold", size: 20))
        }
    }
}
