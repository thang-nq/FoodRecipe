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

            Spacer()
            VStack(alignment: .leading){
        
                Text("Beef Tender Charcoal")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(.custom("ZillaSlab-SemiBold", size: 24))
            
                Text("Calories: 600 Kcal")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(.custom("ZillaSlab-Regular", size: 18))
                
                HStack{
                    Text("Carb: 90g")
                    Text("Proterin: 40g")
                    Text("Fat: 12g")
                }
                .foregroundColor(Color.theme.DarkBlue)
                .font(.custom("ZillaSlab-Regular", size: 18))
            }
            Spacer()
            Button(action:{}, label: {Image(systemName: "trash")})
                .foregroundColor(Color.theme.RedInstance)
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
