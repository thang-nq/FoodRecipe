//
//  RecipeCardView.swift
//  FoodRecipe
//
//  Created by Man Pham on 20/09/2023.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    var saveAction: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            FirebaseImage(imagePathName: recipe.backgroundURL)
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(5)
                .overlay(
                    Button(action: {
                        // Handle save action
                        saveAction(recipe.id!)
                    }) {
                        Image(systemName: recipe.isSaved ? "heart.fill" : "heart")
                    }
                        .foregroundColor(Color("Orange"))
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 16)
                        .font(.system(size: 25))
                        .offset(x: 5, y: 10)
                    , alignment: .topTrailing
                )
            HStack{
                Text(recipe.name)
                    .font(Font.custom.Heading)
            }.frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(recipe.mealType)
                        .font(Font.custom.SubContent)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(getTagColor(tagValue: recipe.mealType))
                        .cornerRadius(8)
                ForEach(recipe.tags, id: \.self) { tag in
                    Text(tag)
                        .font(Font.custom.SubContent)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(getTagColor(tagValue: tag))
                        .cornerRadius(8)
                }
                Spacer()
            }
            
            Text(recipe.intro)
                .font(Font.custom.Content)
                .multilineTextAlignment(.leading)
                .frame(maxHeight: 58)
            
        }.foregroundColor(Color.theme.Black)
            .padding(.bottom, 10)
    }
}


struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: .sampleRecipe, saveAction: {mock in})
    }
}
