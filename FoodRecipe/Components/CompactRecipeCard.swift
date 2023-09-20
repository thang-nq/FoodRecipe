//
//  CompactRecipeCard.swift
//  FoodRecipe
//
//  Created by Man Pham on 16/09/2023.
//

import SwiftUI

struct CompactRecipeCard: View {
    var recipe: Recipe
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: {}).navigationBarHidden(true)) {
            VStack(alignment: .leading, spacing: 8) {
                FirebaseImage(imagePathName: recipe.backgroundURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 150)
                    .frame(height: 200)
                    .cornerRadius(20)
                    .clipped()
                Text(recipe.name)
                    .font(.custom("ZillaSlab-Regular", size: 15)).fontWeight(.medium)
                    .kerning(0.552)
                    .foregroundColor(Color.theme.Black)
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
                CompactRecipeCard(recipe: Recipe.sampleRecipe)
                CompactRecipeCard(recipe: Recipe.sampleRecipe)
            }
            GridRow {
                CompactRecipeCard(recipe: Recipe.sampleRecipe)
                CompactRecipeCard(recipe: Recipe.sampleRecipe)
            }
        }
    }
}
