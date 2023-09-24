/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tuan Le
  ID: s3836290
  Created  date: 20/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct MyRecipeCard: View {
    
    @StateObject private var detailVM = RecipeDetailViewModel()
    var recipe : Recipe
    var body: some View {
        HStack(alignment: .center){
            // Display the recipe image using FirebaseImage
            FirebaseImage(imagePathName: recipe.backgroundURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5){
                
                // Display the recipe name
                Text(recipe.name)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
                
                // Display tags associated with the recipe
                HStack(spacing: 5) {
                    ForEach(recipe.tags, id: \.self){ tag in
                        Tag(text: tag, tagColor: getTagColor(tagValue: tag))
                    }
                }
                
                // Display the creation date of the recipe
                Text(recipe.createdAt)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.Content)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                // Navigate to the recipe update view
                NavigationLink(destination: UpdateRecipeView(recipeId: recipe.id!)) {
                    Image(systemName: "highlighter")
                        .foregroundColor(Color.theme.DarkBlue)
                }
                // Button to delete the recipe
                Button(action:{
                    Task {
                        do {
                            try await detailVM.deleteRecipe(recipeID: recipe.id!)
                        } catch {
                            // Handle the error here if deletion fails
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

    }
}

// apply RoudnedConrners component to define background style
private extension MyRecipeCard {
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.RecipeCardBg, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: Color.theme.DarkBlueInstance.opacity(0.2) ,radius: 5)
    }
}
