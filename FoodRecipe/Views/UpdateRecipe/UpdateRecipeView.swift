//
//  UpdateRecipeView.swift
//  FoodRecipe
//
//  Created by Tien on 19/09/2023.
//

import SwiftUI
import SlidingTabView
import PhotosUI

struct UpdateRecipeView: View {
    @StateObject var updateVM = UpdateRecipeViewModel()
    @StateObject var detailVM = RecipeDetailViewModel()
    //MARK: VARIABLES
    @State private var selectedTabIndex = 0
    @State private var isLoading = false

    func fetchRecipeDetail() async{
        if let recipe = detailVM.recipe{
            updateVM.recipeId = "NSaOOqCRtynqDIMDMy0g"
            updateVM.backgroundPhoto = nil
            updateVM.recipeName = recipe.name
            updateVM.cookingTime = recipe.cookingTime
            updateVM.servingSize = recipe.servingSize
            updateVM.description = recipe.intro
            updateVM.calories = recipe.calories
            updateVM.carb = recipe.carb
            updateVM.protein = recipe.protein
            updateVM.fat = recipe.fat
            updateVM.sugars = recipe.sugars
            updateVM.salt = recipe.salt
            updateVM.saturates = recipe.saturates
            updateVM.fibre = recipe.fibre
            updateVM.currentSelectedTags = recipe.tags
            updateVM.currentMealType = recipe.mealType
            updateVM.Ingredients = recipe.ingredients
            updateVM.currentSelectedMealTypes.append(recipe.mealType)
            print(updateVM.currentSelectedMealTypes)
            print("hello")
            print(updateVM.currentSelectedTags)
        }
    }
    func addCookingSteps() async{
        if let recipe = detailVM.recipe{
            updateVM.Steps = recipe.steps.map { $0.context }
            //photolist
        }
        
    }
    var body: some View {
        ZStack{
                VStack{
                    if let recipe = detailVM.recipe{
                        VStack {
                            topBar
                                .accessibilityLabel("Top bar")

                            slidingTab
                                .accessibilityLabel("Sliding tab")
                            
                        }
                    }
                }
        }
        .onAppear {
            Task(priority: .medium) {
                do {
                    try await detailVM.getRecipeDetail(recipeID: "NSaOOqCRtynqDIMDMy0g")
                    if let recipe = detailVM.recipe {
                    }else {
                        detailVM.getMockRecipeDetail()
                    }
                    await fetchRecipeDetail()
                    await addCookingSteps()
                } catch {
                    // Handle any errors that occur during the async operation
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct UpdateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRecipeView()
    }
}

private extension UpdateRecipeView{
    
    //MARK: TOP BAR UI
    var topBar: some View{
        HStack {
            Spacer()
            // Title of the view
            Text("Create new recipe")
                .font(.custom("ZillaSlab-Bold", size: 25))
                .padding(.leading, 70)
            Text(updateVM.currentSelectedMealTypes[0])
            ForEach(updateVM.currentSelectedTags, id: \.self) { tag in
                Text(tag)}
            Spacer()
            
            // Button create new recipe
            Button(action: {
                // Create recipe
//                updateVM.createRecipe()
                updateVM.printMealTags()
                updateVM.updateRecipe()
            }) {
                Text("Create")
                    .font(.system(size: 20))
                
            }.padding(.trailing, 20)
        }
    }
    
    //MARK: SLIDING TAB UI
    var slidingTab: some View{
        VStack{
            SlidingTabView(selection: $updateVM.selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.OrangeInstance, selectionBarColor: Color.theme.OrangeInstance)
            // Check the selected tab index
            if updateVM.selectedTabIndex == 0 {
                UpdateIntroView(backgroundPhoto: $updateVM.backgroundPhoto ,recipeName: $updateVM.recipeName, cookingTime: $updateVM.cookingTime, servingSize: $updateVM.servingSize, description: $updateVM.description, calories: $updateVM.calories, carb: $updateVM.carb, protein: $updateVM.protein, fat: $updateVM.fat, sugars: $updateVM.sugars, salt: $updateVM.salt, saturates: $updateVM.saturates, fibre: $updateVM.fibre, currentSelectedTags: $updateVM.currentSelectedTags, currentSelectedMealTypes: $updateVM.currentSelectedMealTypes)
            }
            if updateVM.selectedTabIndex == 1 {
                UpdateIngredientsView(Ingredients: $updateVM.Ingredients)
            }
            if updateVM.selectedTabIndex == 2 {
                UpdateStepsView(Steps: $updateVM.Steps, listStepsPhoto: $updateVM.listStepsPhoto, backgroundPhoto: $updateVM.backgroundPhoto)
            }
        }
    }
    
}
