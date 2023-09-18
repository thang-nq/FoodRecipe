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
    //MARK: VARIABLES
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
    @State private var selectedTabIndex = 0
    @State private var isLoading = false
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
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
                await loading()
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
                await resetTheCreateRecipeForm()
                await cancelLoading()
                await showSuccessPopup()
            }
        }
    }
    
    var body: some View {
        
        //MARK: MAIN LAYOUT
        ZStack{
            
            VStack {
                
                topBar
                    .accessibilityLabel("Top bar")
                
                slidingTab
                    .accessibilityLabel("Sliding tab")
                
            }
            .overlay(
            // MARK: SHOW THE SUCCESS POP UP
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
            
            // MARK: CHECK LOADING
            if (isLoading == true){
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .background(Color.clear)
                    
                    Progress(loadingSize: 3)
                }
            }
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}

private extension CreateRecipeView{
    
    //MARK: TOP BAR UI
    var topBar: some View{
        HStack {
            Spacer()
            // Title of the view
            Text("Create new recipe")
                .font(.custom("ZillaSlab-Bold", size: 25))
                .padding(.leading, 70)
            
            Spacer()
            
            // Button create new recipe
            Button(action: {
                // Create recipe
                createRecipe()
            }) {
                Text("Create")
                    .font(.system(size: 20))
                
            }.padding(.trailing, 20)
        }
    }
    
    //MARK: SLIDING TAB UI
    var slidingTab: some View{
        VStack{
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
            // Check the selected tab index
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
    }
    
}
