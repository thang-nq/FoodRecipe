//
//  CookModeView.swift
//  FoodRecipe
//
//  Created by Man Pham on 16/09/2023.
//

import SwiftUI

struct CookModeView: View {
    var recipe: Recipe
    var body: some View {
        VStack {
            Image("soup")
//                 FirebaseImage(imagePathName: recipeDetail.backgroundURL)
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: .infinity,height: 408)
//                                    .clipped()
        }
    }
}

struct CookModeView_Previews: PreviewProvider {
    static var previews: some View {
        CookModeView(
            recipe: Recipe(name: "Crispy Pork",
                           creatorID: "randomid",
                           intro: "This is a healthy dish",
                           servingSize: 3,
                           cookingTime: 90,
                           calories: 740,
                           carb: 15,
                           protein: 30,
                           ingredients: ["300g Pork", "20g Salt"],
                           tags: ["Pork", "Dinner"])
        )
    }
}
