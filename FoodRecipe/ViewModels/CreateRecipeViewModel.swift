//
//  CreateRecipeViewModel.swift
//  FoodRecipe
//
//  Created by Tien on 18/09/2023.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
class CreateRecipeViewModel: ObservableObject {
    @StateObject private var homeVM = HomeViewModel()
    //MARK: VARIABLES
    @Published var userId = UserManager.shared.currentUser!.id
    @Published var backgroundPhoto: PhotosPickerItem? = nil
    @Published var cookingTime : Int = 0
    @Published var servingSize : Int = 0
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
    
    func printId() async{
        print(userId)
    }
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
    
    // Adding Cooking Steps with photo function
    func addingCookingSteps() async{
        for index in 0..<Steps.count {
            let context = Steps[index]
            var imageData: PhotosPickerItem? = nil
            
            if index < listStepsPhoto.count {
                if let photo = listStepsPhoto[index] {
                    imageData = photo
                } else {
                    imageData = backgroundPhoto
                }
            } else {
                imageData = backgroundPhoto
            }
            
            let cookingStep = CookingStepInterface(context: context, imageData: imageData, stepNumber: index + 1)
            cookingSteps.append(cookingStep)
        }
    }
    
    // Show success pop up function
    func showSuccessPopup() async{
        showPopUp = true
        popUpIcon = "checkmark.message.fill"
        popUptitle = "Create recipe success"
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
    
    // Create recipe function
    func createRecipe(){
        getMealType()
        // Validate input field
        if recipeName.isEmpty || cookingTime == 0 || servingSize == 0 || backgroundPhoto == nil || description.isEmpty || Ingredients.isEmpty || Steps.isEmpty || currentMealType.isEmpty || calories == 0 {
            showPopUp = true
            popUpIcon = "xmark"
            popUptitle = "Missing Information"
            popUpContent = "Please fill in all fields in Intro, Ingredients, Steps."
            popUpIconColor = Color.theme.RedInstance
        } else{
            recipeValidated = true
        }
        
        // Creating recipe when the inputs are validated
        if (recipeValidated == true){
            Task {
                await printId()
                await loading()
                await addingCookingSteps()
                await homeVM.addRecipe(recipe: Recipe(name: recipeName,
                                                          creatorID: userId,
                                                          mealType: currentMealType,
                                                          intro: description,
                                                          servingSize: servingSize,
                                                          cookingTime: cookingTime,
                                                          calories: calories,
                                                          carb: carb,
                                                          protein: protein,
                                                          fat: fat,
                                                          sugars: sugars,
                                                          salt: salt,
                                                          saturates: saturates,
                                                          fibre: fibre,
                                                          ingredients: Ingredients,
                                                          tags: currentSelectedTags),
                                           image: backgroundPhoto,
                                           cookingSteps: cookingSteps
                )
                await resetTheCreateRecipeForm()
                await cancelLoading()
                await showSuccessPopup()
            }
        }
    }
    
    //MARK: TUAN'S TEST
    let recipeNameLimit = 25
    
    @Published var recipeName = "" {
        didSet {
            if recipeName.count > recipeNameLimit {
                recipeName = String(recipeName.prefix(recipeNameLimit))
            }
        }
    }
    
    let descriptionLimit = 150
    @Published var description = "" {
        didSet {
            if description.count > descriptionLimit {
                description = String(description.prefix(descriptionLimit))
            }
        }
    }
    
    func isValidCreate() -> Bool {
        return recipeName.isEmpty || cookingTime == 0 || servingSize == 0 || backgroundPhoto == nil || description.isEmpty || Ingredients.isEmpty || Steps.isEmpty || currentSelectedMealTypes.isEmpty || calories == 0
    }
}
