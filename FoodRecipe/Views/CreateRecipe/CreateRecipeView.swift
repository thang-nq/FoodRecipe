//
//  CreateRecipeView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import SlidingTabView
import PhotosUI

struct CreateRecipeView: View {
    @StateObject var homeVM = HomeViewModel()
    @State private var backgroundPhoto: PhotosPickerItem? = nil
    @State private var recipeName = ""
    @State private var cookingTime : Int = 0
    @State private var servingSize : Int = 0
    @State private var description = ""
    @State private var calories: Int = 0
    @State private var carb: Int = 0
    @State private var protein: Int = 0
    @State private var fat: Int = 0
    @State private var sugars: Int = 0
    @State private var salt: Int = 0
    @State private var saturates: Int = 0
    @State private var fibre: Int = 0
    
    @State private var currentSelectedTags: [String] = []
    @State private var currentSelectedMealTypes: [String] = []
    @State private var currentMealType : String = ""
    
    @State private var Ingredients: [String] = []
    
    @State private var Steps: [String] = []
    @State private var listStepsPhoto: [PhotosPickerItem?] = []
    
    @State private var cookingSteps: [CookingStepInterface] = []
    @State private var recipeValidated: Bool = false
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    @State private var selectedTabIndex = 0
    
//    func addingCookingSteps (){
//
//        for index in 0..<Steps.count {
//            let context = Steps[index]
//            var imageData: PhotosPickerItem? = nil
//
//            if index < listStepsPhoto.count {
//                imageData = listStepsPhoto[index]
//            }
//
//            let cookingStep = CookingStepInterface(context: context, imageData: imageData, stepNumber: index + 1)
//            cookingSteps.append(cookingStep)
//        }
//    }
    func getMealType(){
        if(currentSelectedMealTypes.isEmpty){
            currentMealType = ""
        }else {
            let mealType = currentSelectedMealTypes[0]
            currentMealType = mealType
        }
    }
    //Adding Cooking Steps function
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
    func showSuccessPopup() async{
        showPopUp = true
        popUpIcon = "checkmark.message.fill"
        popUptitle = "Create recipe success"
        popUpContent = "You can check your recipe in the My Recipe section"
        popUpIconColor = Color.theme.GreenInstance
    }
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
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Create new recipe")
                    .font(.custom("ZillaSlab-Bold", size: 25))
                    .padding(.leading, 70)
                
                Spacer()
                
                Button(action: {
                    getMealType()
                    if recipeName.isEmpty || cookingTime == 0 || servingSize == 0 || backgroundPhoto == nil || description.isEmpty || Ingredients.isEmpty || Steps.isEmpty || currentMealType.isEmpty || currentSelectedTags.isEmpty || Steps.isEmpty {
                        showPopUp = true
                        popUpIcon = "xmark"
                        popUptitle = "Missing Information"
                        popUpContent = "Please fill in all fields in Intro, Ingredients, Steps."
                        popUpIconColor = Color.theme.RedInstance
                    } else{
                        recipeValidated = true
                    }
                    if (recipeValidated == true){
                        Task {
                            await addingCookingSteps()
                            try await homeVM.addRecipe(recipe: Recipe(name: recipeName,
                                                                      creatorID: "99",
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
                            await showSuccessPopup()
                            await resetTheCreateRecipeForm()
                        }
                    }
                }) {
                    Text("Create")
                        .font(.system(size: 20))
            
                }.padding(.trailing, 20)
            }
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
            
            if selectedTabIndex == 0 {
                CreateIntroView(backgroundPhoto: $backgroundPhoto ,recipeName: $recipeName, cookingTime: $cookingTime, servingSize: $servingSize, description: $description, calories: $calories, carb: $carb, protein: $protein, fat: $fat, sugars: $sugars, salt: $salt, saturates: $saturates, fibre: $fibre, currentSelectedTags: $currentSelectedTags, currentSelectedMealTypes: $currentSelectedMealTypes)
            }
            
            if selectedTabIndex == 1 {
                CreateIngredientsView(Ingredients: $Ingredients)
            }
            
            if selectedTabIndex == 2 {
                CreateStepsView(Steps: $Steps, listStepsPhoto: $listStepsPhoto, backgroundPhoto: $backgroundPhoto)
            }
            
        }
        .overlay(
            ZStack {
                if showPopUp {
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                }
            }
            .opacity(showPopUp ? 1 : 0)
        )
        .background(Color.theme.White)
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}

