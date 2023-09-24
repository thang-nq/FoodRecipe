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

struct RecipeCardView: View {
    var recipe: Recipe
    var saveAction: (String) -> Void = {mock in}
    var hideSave: Bool = false
    
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
                        Image(systemName: recipe.isSaved ? "heart.circle" : "heart.circle.fill")
                    }
                        .foregroundColor(recipe.isSaved ? Color.theme.Orange : Color.theme.DarkGray)
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 16)
                        .font(.system(size: 25))
                        .offset(x: 5, y: 10)
                        .opacity(hideSave ? 0 : 1)
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
            
        }
        .foregroundColor(Color.theme.Black)
        .padding(10)
        .background(backGroundStyle)
        
    }
}


struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RecipeCardView(recipe: .sampleRecipe, saveAction: {mock in})
            RecipeCardView(recipe: .sampleRecipe, saveAction: {mock in})
        }
    }
}

private extension RecipeCardView {
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.DarkGray.opacity(0.1), tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: Color.theme.LightGray.opacity(0.1) ,radius: 2)
    }
}
//                                    Color("DarkGray").opacity(0.1)
