/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/


import Foundation
import PhotosUI
import SwiftUI

// View model for Update recipe screen
@MainActor
class UpdateRecipeViewModel: ObservableObject {
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var detailVM = RecipeDetailViewModel()
    //MARK: VARIABLES
    @Published var recipeId = ""
    @Published var backgroundPhoto: PhotosPickerItem? = nil
    @Published var recipeName = ""
    @Published var cookingTime : Int = 0
    @Published var servingSize : Int = 0
    @Published var description = ""
    @Published var calories: Int = 0
    @Published var carb: Int = 0
    @Published var protein: Int = 0
    @Published var fat: Int = 0
    @Published var sugars: Int = 0
    @Published var salt: Int = 0
    @Published var saturates: Int = 0
    @Published var fibre: Int = 0
    @Published var currentSelectedTags: [String] = []
    @Published var currentSelectedMealTypes: [String] = []
    @Published var currentMealType : String = ""
    @Published var Ingredients: [String] = []
    @Published var Steps: [String] = []
    @Published var listStepsPhoto: [PhotosPickerItem?] = []
    @Published var stepId: [String] = []
    @Published var cookingSteps: [CookingStepInterface] = []
    @Published var recipeValidated: Bool = false
    @Published var selectedTabIndex = 0
    @Published var isLoading = false
    
    //MARK: POP UP VARIABLES
    @Published var showPopUp = false
    @Published var popUpIcon = ""
    @Published var popUptitle = ""
    @Published var popUpContent = ""
    @Published var popUpIconColor = Color.theme.BlueInstance
    
    
    //MARK: FUNCTION
    // Get meal type function
    func getMealType(){
        if(currentSelectedMealTypes.isEmpty){
            currentMealType = ""
        }else {
            let mealType = currentSelectedMealTypes[0]
            currentMealType = mealType
        }
    }
    
    
    // Show success pop up function
    func showSuccessPopup() async{
        showPopUp = true
        popUpIcon = "checkmark.message.fill"
        popUptitle = "Update recipe success"
        popUpContent = "You can check your recipe in the My Recipe section"
        popUpIconColor = Color.theme.GreenInstance
    }
    
    // Reset recipe function
    func resetTheCreateRecipeForm() async{
        backgroundPhoto = nil
        recipeName = ""
        cookingTime = 0
        servingSize = 0
        description = ""
        calories = 0
        carb = 0
        protein = 0
        fat = 0
        sugars = 0
        salt = 0
        saturates = 0
        fibre = 0
        currentSelectedTags = []
        currentSelectedMealTypes = []
        currentMealType = ""
        Ingredients = []
        Steps = []
        listStepsPhoto = []
        cookingSteps = []
        recipeValidated = false
    }
    
    // Loading
    func loading() async{
        isLoading = true
    }
    
    // Cancel loading
    func cancelLoading() async{
        isLoading = false
    }
    
    // Update recipe
    func updateRecipe(){
        getMealType()
        if  (recipeName.isEmpty || cookingTime == 0 || servingSize == 0 || description.isEmpty || Ingredients.isEmpty || Steps.isEmpty || currentMealType.isEmpty || calories == 0 ){
            showPopUp = true
            popUpIcon = "xmark"
            popUptitle = "Missing Information"
            popUpContent = "Please fill in all fields in Intro, Ingredients, Steps."
            popUpIconColor = Color.theme.RedInstance
        } else {
            recipeValidated = true
        }
        if (recipeValidated == true){
            Task{
                await loading()
                if backgroundPhoto == nil{
                    await detailVM.updateRecipe(recipeID: recipeId, updateData: updateRecipeInterface(name: recipeName, mealType: currentMealType, intro: description, servingSize: servingSize, cookingTime: cookingTime, calories: calories, carb: carb, protein: protein, fat: fat, sugars: sugars, salt: salt, saturates: saturates, fibre: fibre, ingredients: Ingredients, tags: currentSelectedTags))
                }else {
                    await detailVM.updateRecipe(recipeID: recipeId, updateData: updateRecipeInterface(name: recipeName, mealType: currentMealType, backgroundImage: backgroundPhoto, intro: description, servingSize: servingSize, cookingTime: cookingTime, calories: calories, carb: carb, protein: protein, fat: fat, sugars: sugars, salt: salt, saturates: saturates, fibre: fibre, ingredients: Ingredients, tags: currentSelectedTags))
                }
                await cancelLoading()
                await showSuccessPopup()
            }
        }
    }
    func isValidCreate() -> Bool {
        return recipeName.isEmpty || cookingTime == 0 || servingSize == 0 || description.isEmpty || Ingredients.isEmpty || Steps.isEmpty || currentSelectedMealTypes.isEmpty || calories == 0
    }
}

