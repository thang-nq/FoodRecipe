//
//  RecipeCardView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack{
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(5)
            HStack{
                Text(recipe.name)
                        .font(.custom("ZillaSlab-SemiBold", size: 26))
                        .padding(.top, 10)
                        .frame(width: 220, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(recipe.tag)
                            .font(.custom("ZillaSlab-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color("Orange"))
                            .cornerRadius(8)
                Spacer()
            }.padding(.bottom, 10)
                  
            Text(recipe.description)
                .font(.custom("ZillaSlab-Regular", size: 20))
            
            }
            .overlay(
                        Button(action: {
                        // Handle save action
                        }) {
                            Image(systemName: "heart")
                        }
                        .foregroundColor(Color("Orange"))
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 16)
                        .font(.system(size: 25))
                        .offset(x:140, y:20)
            )
        .padding(.bottom, 10)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipes[0])
    }
}
