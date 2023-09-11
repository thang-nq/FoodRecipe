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
            Image("recipe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(5)
            HStack{
                VStack{
                    Text(recipe.name)
                        .font(.title2.bold())
                }
              
                Spacer()
            }
            .padding(.top, 10)
            
            HStack {
                Text(recipe.tag)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color("Orange"))
                            .cornerRadius(8)
                Spacer()
            }.padding(.bottom, 10)
                  
            
            Text(recipe.description)
               
            
        }
        .buttonStyle(PlainButtonStyle())
        .overlay(
                            Button(action: {
                                // Handle save action
                            }) {
                                Image("save")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.trailing, 16)
                            .frame(width: 44, height: 44)
                            .offset(x:140, y:10)
                        )
        .overlay(
                            Button(action: {
                                // Handle like action
                            }) {
                                Image("heart")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.trailing, 16)
                            .frame(width: 44, height: 44)
                            .offset(x:110, y:10)
                        )
        .padding(.bottom, 10)
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipes[0])
    }
}
