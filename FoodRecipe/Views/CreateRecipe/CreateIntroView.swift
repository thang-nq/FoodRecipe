//
//  CreateIntroView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import PhotosUI

struct CreateIntroView: View {
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
    
    func selectTag(tag: String) {
        if(currentSelectedTags.contains(tag)) {
            if let index = currentSelectedTags.firstIndex(of: tag) {
                currentSelectedTags.remove(at: index)
            }
        } else {
            currentSelectedTags.append(tag)
        }
    }
    
//    func selectMealType(tag: String) {
//        if(currentSelectedMealTypes.contains(tag)) {
//            if let index = currentSelectedMealTypes.firstIndex(of: tag) {
//                currentSelectedMealTypes.remove(at: index)
//            }
//        } else {
//            currentSelectedMealTypes.append(tag)
//        }
//    }
    
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
        ScrollView{
            VStack{
                InputFieldRecipe(text: $recipeName, title: "Title", placeHolder: "Enter title")
                HStack(){
                    NumberInput(value: $cookingTime, name: "Cook time", placeHolder: "Enter minutes")
                        .frame(width: 150)
                        .padding(.trailing, 30)
                    NumberInput(value: $servingSize, name: "Serving size", placeHolder: "Enter serving size")
                        .frame(width: 150)
                    Spacer()
                }
                
                .padding(.top, 5)
                
                PhotosPicker(selection: $backgroundPhoto, photoLibrary: .shared()) {
                    Label("Select a photo for the recipe", systemImage: "photo.fill")
                }.padding(.vertical, 10)
                
                HStack{
                    Text("Description")
                        .font(.custom("ZillaSlab-SemiBold", size: 22))
                        .padding(.leading, 15)
                    Spacer()
                }
                TextEditor(text: $description)
                    .font(.custom("ZillaSlab-Regular", size: 16))
                    .frame(height: 250)
                    .colorMultiply(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
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
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct InputFieldRecipe: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("ZillaSlab-SemiBold", size: 22))
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            } else {
                TextField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            }
            
            Divider()
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct NumberInput: View {
    @Binding var value: Int
    let name: String
    let placeHolder: String
//    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(name)
                .font(.custom("ZillaSlab-SemiBold", size: 22))
//            if isSecureField {
//                SecureField(placeHolder, value: $value)
//                    .font(.custom("ZillaSlab-Regular", size: 16))
//            } else {
//                TextField(placeHolder, value: $value, formatter: NumberFormatter())
//                    .font(.custom("ZillaSlab-Regular", size: 16))
//            }
            TextField(placeHolder, value: $value, formatter: NumberFormatter())
                .font(.custom("ZillaSlab-Regular", size: 15))
            
            Divider()
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct NutritionInput: View {
    @Binding var value: Int
    let name: String
    let placeHolder: String
//    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(name)
                .font(.custom("ZillaSlab-Regular", size: 15))
//            if isSecureField {
//                SecureField(placeHolder, value: $value)
//                    .font(.custom("ZillaSlab-Regular", size: 16))
//            } else {
//                TextField(placeHolder, value: $value, formatter: NumberFormatter())
//                    .font(.custom("ZillaSlab-Regular", size: 16))
//            }
            TextField(placeHolder, value: $value, formatter: NumberFormatter())
                .font(.custom("ZillaSlab-Regular", size: 15))
            
            Divider()
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct CreateIntroView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIntroView(backgroundPhoto: .constant(nil), recipeName: .constant(""), cookingTime: .constant(0), servingSize: .constant(0), description: .constant(""), calories: .constant(0), carb: .constant(0), protein: .constant(0), fat: .constant(0), sugars: .constant(0), salt: .constant(0), saturates: .constant(0), fibre: .constant(0), currentSelectedTags: .constant([]), currentSelectedMealTypes: .constant([]))
    }
}
