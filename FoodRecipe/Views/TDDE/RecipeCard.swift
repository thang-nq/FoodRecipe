//
//  RecipeCard.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 18/09/2023.
//

import SwiftUI

struct RecipeCard: View {
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
            
                Text("Calories: 600 Kcal")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubContentRegular)
                
                HStack{
                    Text("Carb: 90g")
                    Text("Proterin: 40g")
                    Text("Fat: 12g")
                }
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.SubContentRegular)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                Button(action:{}, label: {Image(systemName: "info.circle.fill")})
                    .foregroundColor(Color.theme.BlueInstance)
                
                Button(action:{}, label: {Image(systemName: "trash")})
                    .foregroundColor(Color.theme.RedInstance)
            }

        }
        .foregroundColor(Color.theme.DarkWhite)
        .padding()
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard()
    }
}
