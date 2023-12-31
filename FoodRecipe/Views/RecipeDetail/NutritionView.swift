/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI

struct NutritionView: View {
    var recipe: Recipe
    var body: some View {
        SectionContainerView {
            SectionTitleView(title: "Nutrition")
            ForEach(Array(stride(from: 0, to: recipe.nutritionsArray.count, by: 4)), id: \.self) { index in
                HStack {
                    NutritionElementView(item: recipe.nutritionsArray[index])
                    if(index + 1 < recipe.nutritionsArray.count) {
                        NutritionElementView(item: recipe.nutritionsArray[index+1])
                    }
                    if(index + 2 < recipe.nutritionsArray.count) {
                        NutritionElementView(item: recipe.nutritionsArray[index+2])
                    }
                    if(index + 3 < recipe.nutritionsArray.count) {
                        NutritionElementView(item: recipe.nutritionsArray[index+3])
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
        VStack (spacing: 4){
            Text(item.type)
                .font(.custom.Content)
                .foregroundColor(Color.theme.WhiteInstance)
                .bold()
            Text("\(item.value)")
                .font(.custom.ContentBold)
                .foregroundColor(Color.theme.WhiteInstance)
                .fontWeight(.semibold)
        }
        .padding(10)
        .frame(width: 80, height: 60)
        .background(Color.theme.LightOrange)
        .cornerRadius(10)
    }
}

