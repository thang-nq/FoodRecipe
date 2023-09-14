//
//  OnLoadingPageView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 14/09/2023.
//

import SwiftUI

struct OnLoadingPageView: View {
    
    var imageName: String
    var iconColor: Color
    var title: String
    var description: String
    let startedButton: Bool
    let nextScreen: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            //MARK: ICON UI
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 230)
                .foregroundColor(iconColor)
            
            //MARK: Title UI
            Text(title)
                .font(.custom("ZillaSlab-BoldItalic", size: 30))
                .foregroundColor(Color.theme.DarkBlueInstance)
            
            //MARK: DESCRIPTION UI
            Text(description)
                .font(.custom("ZillabSlab-Regular", size: 18))
                .foregroundColor(Color.theme.DarkGrayInstance)
                
            
            // MARK: NAVIGATE BUTTON UI
            if startedButton {
                Button(action:{nextScreen()}){
                    Text("Lets get started")
                        .font(.custom("ZillaSlab-SemiBoldItalic", size: 20))
                        .frame(width: 300, height: 50, alignment: .center)
                        .contentShape(Rectangle())
                }
                .foregroundColor(Color.theme.DarkBlueInstance)
                .background(Color.theme.GreenInstance)
                .cornerRadius(8)
                .padding(.top)
                
            } else {
                Button(action:{nextScreen()}){
                    Text("Next")
                        .font(.custom("ZillaSlab-SemiBoldItalic", size: 20))
                        .frame(width: 300, height: 50)
                        .contentShape(Rectangle())
                }
                .foregroundColor(Color.theme.DarkBlueInstance)
                .background(Color.theme.Orange)
                .cornerRadius(8)
                .padding(.top)
            }
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        
    }
}

struct OnLoadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnLoadingPageView(imageName: "star.fill", iconColor: Color.theme.YellowInstance, title: "RecipePal Hello", description: "Welcome to RecipePal, your culinary companion! Discover, cook, and share delicious dishes with our user-friendly app. Let's get cooking!", startedButton: false, nextScreen: {})
    }
}
