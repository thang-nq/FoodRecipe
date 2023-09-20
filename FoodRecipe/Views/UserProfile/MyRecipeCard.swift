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

            VStack(alignment: .leading){
        
                Text("Beef Tender Charcoal")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
            
                HStack {
                    Tag(text: "Vegan")
                }
                
//                Text("Calories: 600 Kcal")
//                    .foregroundColor(Color.theme.DarkBlue)
//                    .font(Font.custom.SubContent)
                
                Text("Created: 19/19/1919")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubContent)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                Button(action:{}, label: {Image(systemName: "highlighter")})
                    .foregroundColor(Color.theme.BlueInstance)
                
                Button(action:{}, label: {Image(systemName: "trash")})
                    .foregroundColor(Color.theme.RedInstance)
            }

        }
        .foregroundColor(Color.theme.DarkWhite)
        .padding()    }
}

struct MyRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeCard()
    }
}
