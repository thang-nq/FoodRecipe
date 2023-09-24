/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tuan Le
  ID: s3836290
  Created  date: 18/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct RecipeCard: View {
    var id: String
    var calories: Int
    var name: String
    var imageURL: String
    var protein: Int
    var fat: Int
    var carb: Int
    
    // Shared TDDE view model
    @StateObject private var tddeVM = TDDEViewModel.shared

    var body: some View {
        HStack(alignment: .center){
            
            // Display the recipe image using FirebaseImage
            FirebaseImage(imagePathName: imageURL)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(Circle())

            VStack(alignment: .leading){
                // Recipe name
                Text(name)
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubHeading)
                // Display the number of calories
                Text("Calories: \(calories)")
                    .foregroundColor(Color.theme.DarkBlue)
                    .font(Font.custom.SubContent)
                // Display the nutritional information (Carb, Protein, Fat)
                HStack{
                    Text("Carb: \(carb)g")
                    Text("Protein: \(protein)g")
                    Text("Fat: \(fat)g")
                }
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.SubContent)
            }
            Spacer()
            VStack(alignment: .center, spacing: 15){
                // Navigation link to the RecipeDetailView
                NavigationLink(destination: RecipeDetailView(recipeId: id, onDissappear: {}).navigationBarHidden(true)) {
                    Image(systemName: "info.circle.fill").foregroundColor(Color.theme.BlueInstance)
                }
                // Button to remove the recipe from TDEE
                Button(action:{
                    Task {
                        await tddeVM.removeRecipeFromTDDE(recipeID: id)
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

private extension RecipeCard {
    // Define the background style for the RecipeCard
    var backGroundStyle: some View {
        RoundedCorners(color: Color.theme.RecipeCardBg, tl: 10, tr: 10, bl:10, br: 10)
            .shadow(color: Color.theme.DarkBlueInstance.opacity(0.2) ,radius: 5)
    }
}
