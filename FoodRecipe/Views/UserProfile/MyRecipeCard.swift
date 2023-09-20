//
//  MyRecipeCard.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 20/09/2023.
//

import SwiftUI

struct MyRecipeCard: View {
    var body: some View {
        HStack(alignment: .center){
            Image("salas")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5){
        
                Text("Beef Tender Charcoal Chee")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
            
                HStack(spacing: 5) {
                    Tag(text: "Healthy", tagColor: Color.theme.GreenInstance)
                    Tag(text: "Peanut", tagColor: Color.theme.LightOrange)
                    Tag(text: "Chicken", tagColor: Color.theme.RedInstance)
                }
                
                Text("Created: 19/19/1919")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.Content)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                Button(action:{}, label: {Image(systemName: "highlighter")})
                    .foregroundColor(Color.theme.DarkBlue)
                
                Button(action:{}, label: {Image(systemName: "trash")})
                    .foregroundColor(Color.theme.RedInstance)
            }
        }
        .padding(5)
        .background(backGroundStyle)
        .foregroundColor(Color.theme.DarkWhite)
        .padding(.horizontal, 10)
      
        
    }
}

struct MyRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeCard()
    }
}

private extension MyRecipeCard {
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.DarkWhiteInstance, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: .black.opacity(0.2) ,radius: 5)
    }
}
