//
//  MyRecipeCard.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 20/09/2023.
//

import SwiftUI

struct MyRecipeCard: View {
    
    @StateObject private var detailVM = RecipeDetailViewModel()
    var recipe : Recipe
    var body: some View {
        HStack(alignment: .center){
            FirebaseImage(imagePathName: recipe.backgroundURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5){
        
                Text(recipe.name)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
            
                HStack(spacing: 5) {
                    ForEach(recipe.tags, id: \.self){ tag in
                        Tag(text: tag, tagColor: getTagColor(tagValue: tag))
                    }
                }
                
                Text(recipe.createdAt)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.Content)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                NavigationLink(destination: UpdateRecipeView(recipeId: recipe.id!)) {
                    Image(systemName: "highlighter")
                        .foregroundColor(Color.theme.DarkBlue)
                }
                Button(action:{
                    Task {
                        do {
                            try await detailVM.deleteRecipe(recipeID: recipe.id!)
                        } catch {
                            // Handle the error here
                            print("Error deleting recipe: \(error)")
                        }
                    }
                }, label: {Image(systemName: "trash")})
                    .foregroundColor(Color.theme.RedInstance)
            }
        }
        .padding(5)
        .background(backGroundStyle)
        .foregroundColor(Color.theme.DarkWhite)
        .padding(.horizontal, 10)
    }
}

struct MyRecipeCard_Previews: PreviewProvider {
    static var previews: some View {


        Group {
            MyRecipeCard(recipe: Recipe.sampleRecipe)
                .previewDisplayName("iOS light")
                .preferredColorScheme(.light)
            
            MyRecipeCard(recipe: Recipe.sampleRecipe)
                .previewDisplayName("iOS dark")
                .preferredColorScheme(.dark)
            
        }

//        MyRecipeCard(recipe: Recipe.sampleRecipe)

    }
}

private extension MyRecipeCard {
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.DarkWhiteInstance, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: .black.opacity(0.2) ,radius: 5)
    }
}
