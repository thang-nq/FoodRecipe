/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Man Pham
  ID: s3804811
  Created  date: 16/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct CompactRecipeCard: View {
    var recipe: Recipe
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: {}).navigationBarHidden(true)) {
            VStack(alignment: .leading, spacing: 4) {
                FirebaseImage(imagePathName: recipe.backgroundURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 150)
                    .frame(height: 200)
                    .cornerRadius(20)
                    .clipped()
                Text(recipe.name)
                    .font(.custom.SubHeading)
                    .foregroundColor(Color.theme.Black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(8)
            .frame(height: 275)
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
