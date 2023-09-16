//
//  NutritionView.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

struct NutritionView: View {
    var recipe: Recipe
    var body: some View {
        SectionContainerView {
            SectionTitleView(title: "Nutrition")
            ForEach(Array(stride(from: 0, to: recipe.nutritionsArray.count, by: 3)), id: \.self) { index in
                HStack {
                    NutritionElementView(item: recipe.nutritionsArray[index])
                    if(index + 1 < recipe.nutritionsArray.count) {
                        NutritionElementView(item: recipe.nutritionsArray[index+1])
                    }
                    if(index + 2 < recipe.nutritionsArray.count) {
                        NutritionElementView(item: recipe.nutritionsArray[index+2])
                    }
                }
            }
        }
        .padding(.top, 300)
        .padding(.horizontal, 25)
    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            Color("LightGray").ignoresSafeArea(.all)
            NutritionView(
                recipe: Recipe(name: "Chicken", creatorID: "820450349", protein: 200, fat: 80, sugars: 20, salt: 30 )
            )
        }
    }
}


struct NutritionElementView: View {
    var item: NutritionItem
    
    var body: some View {
        VStack (spacing: 7){
            Text(item.type)
                .font(.system(size: 18))
                .foregroundColor(Color.theme.White)
                .bold()
            Text("\(item.value)")
                .font(.system(size: 22))
                .foregroundColor(Color.theme.White)
                .fontWeight(.semibold)
        }
        .padding(10)
        .frame(width: 100, height: 80)
        .background(Color.theme.LightOrange)
        .cornerRadius(10)
    }
}

