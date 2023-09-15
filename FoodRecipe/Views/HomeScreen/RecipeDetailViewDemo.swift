//
//  RecipeDetailViewDemo.swift
//  FoodRecipe
//
//  Created by Tien on 15/09/2023.
//

import SwiftUI

struct RecipeDetailViewDemo: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Image(recipe.backgroundURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(recipe.name)
                .font(.title)
                .padding()
        }
        .navigationBarTitle(recipe.name)
    }
}

//struct RecipeDetailViewDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView(recipe: recipes[0])
//    }
//}
