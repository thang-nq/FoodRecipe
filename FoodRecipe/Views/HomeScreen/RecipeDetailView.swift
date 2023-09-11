//
//  RecipeDetailView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(recipe.name)
                .font(.title)
                .padding()
        }
        .navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: recipes[0])
    }
}

