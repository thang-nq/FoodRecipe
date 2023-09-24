/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tien Tran
  ID: s3919657
  Created  date: 19/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import PhotosUI

struct UpdateIntroView: View {
    @AppStorage("isDarkMode") var isDark = false
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
        UpdateIntroView(backgroundPhoto: .constant(nil), recipeName: .constant(""), cookingTime: .constant(0), servingSize: .constant(0), description: .constant(""), calories: .constant(0), carb: .constant(0), protein: .constant(0), fat: .constant(0), sugars: .constant(0), salt: .constant(0), saturates: .constant(0), fibre: .constant(0), currentSelectedTags: .constant([]), currentSelectedMealTypes: .constant([]))
    }
}

private extension UpdateIntroView{
    
    //MARK: TITLE INPUT UI
    var titleInput: some View{
        RequireInputFieldRecipe(text: $recipeName, title: "Title", placeHolder: "Enter title")
    }
    
    //MARK: COOK TIME AND SERVING SIZE UI
    var timeAndServingInput: some View{
        HStack(){
            NumberInput(value: $cookingTime, name: "Cook time", placeHolder: "Enter minutes")
                .frame(width: 170)
                .padding(.trailing, 30)
            NumberInput(value: $servingSize, name: "Serving size", placeHolder: "Enter serving size")
                .frame(width: 180)
            Spacer()
        }
    }
    
    //MARK: ADD PHOTO UI
    var addPhoto: some View{
        HStack{
            PhotosPicker(selection: $backgroundPhoto, photoLibrary: .shared()) {
                Label("Select a photo for the recipe", systemImage: "photo.fill")
            }
            .padding(.vertical, 10)
            .foregroundColor(Color.theme.OrangeInstance)
            .font(Font.custom.SubHeading)
            Text("*")
                .font(.system(size: 22))
                .foregroundColor(Color.theme.RedInstance)
        }
    }
    
    //MARK: DESCRIPTION INPUT UI
    var descriptionInput: some View{
        VStack{
            HStack{
                Text("Description")
                    .font(.custom("ZillaSlab-SemiBold", size: 22))
                    .padding(.leading, 15)
                Text("*")
                    .font(.system(size: 22))
                    .foregroundColor(Color.theme.RedInstance)
                Spacer()
            }
            TextEditor(text: $description)
                .font(Font.custom.Content)
                .frame(height: 250)
                .scrollContentBackground(.hidden)
                .background(isDark ? Color.theme.DarkWhite.opacity(0.2) : Color.theme.DarkWhite)
                .foregroundColor(isDark ? Color.theme.WhiteInstance : Color.theme.Black)
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
                RequireNutritionInput(value: $calories, name: "Calories", placeHolder: "0")
                NutritionInput(value: $carb, name: "Carb", placeHolder: "0")
            }
            HStack{
                NutritionInput(value: $protein, name: "Protein", placeHolder: "0")
                NutritionInput(value: $fat, name: "Fat", placeHolder: "0")
                NutritionInput(value: $sugars, name: "Sugars", placeHolder: "0")
            }
            HStack{
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
                Text("*")
                    .font(.system(size: 22))
                    .foregroundColor(Color.theme.RedInstance)
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
            Text("")
                .frame(height: 150)
        }
    }
}

