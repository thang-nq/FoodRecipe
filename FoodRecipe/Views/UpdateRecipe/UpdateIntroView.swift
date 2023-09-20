//
//  UpdateIntroView.swift
//  FoodRecipe
//
//  Created by Tien on 19/09/2023.
//

import SwiftUI
import PhotosUI

struct UpdateIntroView: View {
    //MARK: VARIABLES
    @Binding var backgroundPhoto: PhotosPickerItem?
    @Binding var recipeName : String
    @Binding var cookingTime : Int
    @Binding var servingSize : Int
    @Binding var description : String
    @Binding var calories: Int
    @Binding var carb: Int
    @Binding var protein: Int
    @Binding var fat: Int
    @Binding var sugars: Int
    @Binding var salt: Int
    @Binding var saturates: Int
    @Binding var fibre: Int
    @Binding var currentSelectedTags: [String]
    @Binding var currentSelectedMealTypes: [String]
    
    var MOCK_TAGS = ["Chicken", "Soup", "Rice", "Pork", "Sandwich", "Eggs", "Duck", "Avocado", "Simple", "Milk"]
    var MOCK_MEAL_TYPES = ["Breakfast", "Brunch", "Lunch", "Dinner", "Snack"]
    
    //MARK: FUNCTION
    // Action select tag
    func selectTag(tag: String) {
        if(currentSelectedTags.contains(tag)) {
            if let index = currentSelectedTags.firstIndex(of: tag) {
                currentSelectedTags.remove(at: index)
            }
        } else {
            currentSelectedTags.append(tag)
        }
    }
    
    // Action select meal type
    func selectMealType(tag: String) {
        if currentSelectedMealTypes.contains(tag) {
            if let index = currentSelectedMealTypes.firstIndex(of: tag) {
                currentSelectedMealTypes.remove(at: index)
            }
        } else {
            currentSelectedMealTypes.removeAll()
            currentSelectedMealTypes.append(tag)
        }
    }

    var body: some View {
        // MARK: MAIN LAYOUT
        ScrollView{
                VStack{
                    titleInput
                        .accessibilityLabel("Title input field")
                    
                    timeAndServingInput
                        .accessibilityLabel("Cook time and serving size input field")
                    
                    addPhoto
                        .accessibilityLabel("Select photo for recipe")
                    
                    descriptionInput
                        .accessibilityLabel("Description input field")
                    
                    nutritionInput
                        .accessibilityLabel("Nutrition input field")
                    
                    mealTypeAndTagsInput
                        .accessibilityLabel("Meal type and tags input field")
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct UpdateIntroView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIntroView(backgroundPhoto: .constant(nil), recipeName: .constant(""), cookingTime: .constant(0), servingSize: .constant(0), description: .constant(""), calories: .constant(0), carb: .constant(0), protein: .constant(0), fat: .constant(0), sugars: .constant(0), salt: .constant(0), saturates: .constant(0), fibre: .constant(0), currentSelectedTags: .constant([]), currentSelectedMealTypes: .constant([]))
    }
}

private extension UpdateIntroView{
    
    //MARK: TITLE INPUT UI
    var titleInput: some View{
        InputFieldRecipe(text: $recipeName, title: "Title", placeHolder: "Enter title")
    }
    
    //MARK: COOK TIME AND SERVING SIZE UI
    var timeAndServingInput: some View{
        HStack(){
            NumberInput(value: $cookingTime, name: "Cook time", placeHolder: "Enter minutes")
                .frame(width: 150)
                .padding(.trailing, 30)
            NumberInput(value: $servingSize, name: "Serving size", placeHolder: "Enter serving size")
                .frame(width: 150)
            Spacer()
        }
    }
    
    //MARK: ADD PHOTO UI
    var addPhoto: some View{
        PhotosPicker(selection: $backgroundPhoto, photoLibrary: .shared()) {
            Label("Select a photo for the recipe", systemImage: "photo.fill")
        }.padding(.vertical, 10)
    }
    
    //MARK: DESCRIPTION INPUT UI
    var descriptionInput: some View{
        VStack{
            HStack{
                Text("Description")
                    .font(.custom("ZillaSlab-SemiBold", size: 22))
                    .padding(.leading, 15)
                Spacer()
            }
            TextEditor(text: $description)
                .font(.custom("ZillaSlab-Regular", size: 16))
                .frame(height: 250)
                .colorMultiply(Color.theme.DarkWhite)
                .cornerRadius(10)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
        }
    }
    
    //MARK: NUTRITION INPUT UI
    var nutritionInput: some View{
        VStack{
            HStack{
                Text("Nutrition")
                    .font(.custom("ZillaSlab-SemiBold", size: 22))
                    .padding(.leading, 15)
                    .padding(.bottom, 10)
                Spacer()
            }
            HStack{
                NutritionInput(value: $calories, name: "Calories", placeHolder: "0")
                NutritionInput(value: $carb, name: "Carb", placeHolder: "0")
                NutritionInput(value: $protein, name: "Protein", placeHolder: "0")
                NutritionInput(value: $fat, name: "Fat", placeHolder: "0")
            }
            HStack{
                NutritionInput(value: $sugars, name: "Sugars", placeHolder: "0")
                NutritionInput(value: $salt, name: "Salt", placeHolder: "0")
                NutritionInput(value: $saturates, name: "Saturates", placeHolder: "0")
                NutritionInput(value: $fibre, name: "Fibre", placeHolder: "0")
            }
        }
    }
    
    //MARK: MEAL TYPE AND TAGS INPUT UI
    var mealTypeAndTagsInput: some View{
        VStack{
            HStack{
                Text("Meal types")
                    .font(.custom("ZillaSlab-SemiBold", size: 22))
                    .padding(.leading, 15)
                Spacer()
            }
            TagsFilterView(tags: MOCK_MEAL_TYPES, currentSelectedTags: $currentSelectedMealTypes, action: selectMealType)
                .padding(.leading, 15)
            HStack{
                Text("Tags")
                    .font(.custom("ZillaSlab-SemiBold", size: 22))
                    .padding(.leading, 15)
                Spacer()
            }
            TagsFilterView(tags: MOCK_TAGS, currentSelectedTags: $currentSelectedTags, action: selectTag)
                .padding(.leading, 15)
        }
    }
}
