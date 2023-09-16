//
//  CompactRecipeCard.swift
//  FoodRecipe
//
//  Created by Man Pham on 16/09/2023.
//

import SwiftUI

struct CompactRecipeCard: View {
    var recipe: Recipe = Recipe(name: "Crispy Pork",
                                creatorID: "randomshit",
                                intro: "This is a healthy dish",
                                servingSize: 3,
                                cookingTime: 90,
                                calories: 740,
                                carb: 15,
                                protein: 30,
                                ingredients: ["300g Pork", "20g Salt"],
                                tags: ["Pork", "Dinner"])
    var body: some View {
        Button {
            // Navigate to Recipe Detail
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Image("soup")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(20)
                    .clipped()
                Text("Chicken Soup Oven Potato")
                    .font(.custom("ZillaSlab-Bold", size: 20)).fontWeight(.medium)
                    .kerning(0.552)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        
    }
}

struct CompactRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        Grid {
            GridRow {
                CompactRecipeCard()
                CompactRecipeCard()
            }
            GridRow {
                CompactRecipeCard()
                CompactRecipeCard()
            }
        }
    }
}
