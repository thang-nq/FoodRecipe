//
//  RecipeCard.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 18/09/2023.
//

import SwiftUI

struct RecipeCard: View {
    var id: String
    var calories: Int
    var name: String
    var imageURL: String
    var protein: Int
    var fat: Int
    var carb: Int
    @StateObject private var tddeVM = TDDEViewModel.shared
    
    var body: some View {
        HStack(alignment: .center){
            
            FirebaseImage(imagePathName: imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())

            VStack(alignment: .leading){
        
                Text(name)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
            
                Text("Calories: \(calories)")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubContent)
                
                HStack{
                    Text("Carb: \(carb)g")
                    Text("Protein: \(protein)g")
                    Text("Fat: \(fat)g")
                }
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.SubContent)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                Button(action:{}, label: {Image(systemName: "info.circle.fill")})
                    .foregroundColor(Color.theme.BlueInstance)
                
                Button(action:{
                    Task {
                        await tddeVM.removeRecipeFromTDDE(recipeID: id)
                    }
                }, label: {Image(systemName: "trash")})
                    .foregroundColor(Color.theme.RedInstance)
            }

        }
        .padding(5)
        .background(backGroundStyle)
        .foregroundColor(Color.theme.DarkWhite)
        .padding(.horizontal, 10)
    }
}

//struct RecipeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeCard()
//    }
//}

private extension RecipeCard {
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.RecipeCardBg, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: Color.theme.DarkBlueInstance.opacity(0.8) ,radius: 5)
    }
}
