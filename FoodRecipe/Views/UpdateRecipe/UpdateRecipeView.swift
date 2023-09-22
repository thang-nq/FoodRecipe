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
    @AppStorage("isDarkMode") var isDark = false
    @StateObject var updateVM = UpdateRecipeViewModel()
    @StateObject var detailVM = RecipeDetailViewModel()
    //MARK: VARIABLES
    var recipeId : String
    @State private var selectedTabIndex = 0
    @State private var isLoading = false
    @State private var updatingStep = false

    func fetchRecipeDetail() async{
        if let recipe = detailVM.recipe{
            updateVM.recipeId = recipeId
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
            updateVM.stepId = recipe.steps.map { $0.id! }
            updateVM.Steps = recipe.steps.map { $0.context }
        }
    }
    func fetchSteps() async{
        if let recipe = detailVM.recipe{
            updateVM.Steps = recipe.steps.map { $0.context }
        }
    }
    var body: some View {
        ZStack(alignment: .leading){
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
                .environment(\.colorScheme, isDark ? .dark : .light)
                .overlay(
                // MARK: SHOW THE SUCCESS POP UP
                    ZStack {
                        if updateVM.showPopUp {
                            Color.theme.DarkWhite.opacity(0.5)
                                .edgesIgnoringSafeArea(.all)
                            PopUp(iconName: updateVM.popUpIcon , title: updateVM.popUptitle, content: updateVM.popUpContent, iconColor: updateVM.popUpIconColor ,didClose: {updateVM.showPopUp = false})
                        }
                    }
                        .opacity(updateVM.showPopUp ? 1 : 0)
                )
                .background(Color.theme.White)
                .onAppear {
                    Task(priority: .medium) {
                        do {
                            try await detailVM.getRecipeDetail(recipeID: recipeId)
                            if let recipe = detailVM.recipe {
                            }else {
                                detailVM.getMockRecipeDetail()
                            }
                            await fetchRecipeDetail()
                        } catch {
                            // Handle any errors that occur during the async operation
                            print("Error: \(error)")
                        }
                    }
                }
                .onChange(of: updatingStep) { newValue in
                    Task{
                        await fetchSteps()
                    }
                }

            // MARK: CHECK LOADING
            if (updateVM.isLoading == true){
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .background(Color.clear)
                    
                    Progress(loadingSize: 3)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UpdateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRecipeView(recipeId: "NSaOOqCRtynqDIMDMy0g")
    }
}

struct CustomBackButtonRecipe: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
            Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("chevron-left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(10)
                            .background(.white)
                            .clipShape(Circle())
                        
                    }.padding(.leading, 25)
            
    }
}

private extension UpdateRecipeView{
    //MARK: TOP BAR UI
    var topBar: some View{
        HStack {
            Spacer()
            ExitButton()
                
            Spacer()
            // Title of the view
            Text("Update recipe")
                .font(Font.custom.NavigationTitle)
                .padding(.leading, 30)
             
            Spacer()
            
            // Button create new recipe
            Button(action: {
                updateVM.updateRecipe()
            }) {
                Text("Save")
                    .font(.system(size: 20))
            }
            
            .disabled(updateVM.isValidCreate())
            Spacer()
        }
    }
    
    //MARK: SLIDING TAB UI
    var slidingTab: some View{
        VStack{
            SlidingTabView(selection: $updateVM.selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),    activeAccentColor: Color.theme.Orange, inactiveAccentColor : Color.theme.Gray, selectionBarColor: Color.theme.Orange)
            // Check the selected tab index
            if updateVM.selectedTabIndex == 0 {
                UpdateIntroView(backgroundPhoto: $updateVM.backgroundPhoto ,recipeName: $updateVM.recipeName, cookingTime: $updateVM.cookingTime, servingSize: $updateVM.servingSize, description: $updateVM.description, calories: $updateVM.calories, carb: $updateVM.carb, protein: $updateVM.protein, fat: $updateVM.fat, sugars: $updateVM.sugars, salt: $updateVM.salt, saturates: $updateVM.saturates, fibre: $updateVM.fibre, currentSelectedTags: $updateVM.currentSelectedTags, currentSelectedMealTypes: $updateVM.currentSelectedMealTypes)
            }
            if updateVM.selectedTabIndex == 1 {
                UpdateIngredientsView(Ingredients: $updateVM.Ingredients)
            }
            if updateVM.selectedTabIndex == 2 {
                UpdateStepsView(recipeId: recipeId,Steps: $updateVM.Steps, listStepsPhoto: $updateVM.listStepsPhoto, backgroundPhoto: $updateVM.backgroundPhoto, listStepId: $updateVM.stepId)
            }
        }
    }
    
}

