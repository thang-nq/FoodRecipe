/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 11/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import PhotosUI

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var creatorID: String
    var timeStamp: Timestamp = Timestamp(date: Date())
    var createdAt: String = ""
    var creatorName: String = ""
    var creatorAvatar: String = ""
    var mealType: String = "Breakfast"
    var backgroundURL: String = "default.jpeg"
    var intro: String = ""
    var servingSize: Int = 1
    var cookingTime: Int = 10
    var calories: Int = 300
    var carb: Int = 0
    var protein: Int = 0
    var fat: Int = 0
    var sugars: Int = 0
    var salt: Int = 0
    var saturates: Int = 0
    var fibre: Int = 0
    var ingredients: [String] = []
    var tags: [String] = ["Chicken", "Salad"]
    var steps: [CookingStep] = []
    var isSaved: Bool = false
    
    var nutritionsArray: [NutritionItem] {
        let nutritionArr = [
            NutritionItem(type: "Calories", value: self.calories),
            NutritionItem(type: "Carb", value: self.carb),
            NutritionItem(type: "Protein", value: self.protein),
            NutritionItem(type: "Fat", value: self.fat),
            NutritionItem(type: "Sugars", value: self.sugars),
            NutritionItem(type: "Salt", value: self.salt),
            NutritionItem(type: "Saturates", value: self.saturates),
            NutritionItem(type: "fibre", value: self.fibre),
        ]
        return nutritionArr.filter({ $0.value > 0})
    }
    
    static var sampleRecipe: Recipe = Recipe(
        id: "asokdfjaskdfjaso239849iowefj",
        name: "Yakitori Grilled Chicken",
        creatorID: "somerandomID",
        timeStamp: Timestamp(date: Date()),
        createdAt:  "September 11th, 2012",
        creatorName: "Man Pham Quang",
        creatorAvatar: "",
        mealType: "Breakfast",
        backgroundURL:  "default.jpeg",
        intro:  "Grilling beef tenderloin over charcoal is a surefire way to achieve a mouthwatering, smoky flavor and a perfectly juicy and tender result. This recipe guide will walk you through the steps to prepare and grill a delicious beef tenderloin that will impress your family and friends at your next barbecue gathering.",
        servingSize:  1,
        cookingTime:  10,
        calories:  300,
        carb: 100,
        protein: 20,
        fat: 19,
        sugars: 150,
        salt:  30,
        saturates:  80,
        fibre:  20,
        ingredients:  [
            "2 to 3 pounds of beef tenderloin (whole)",
            "2 tablespoons olive oil",
            "4 cloves garlic, minced",
            "2 tablespoons fresh rosemary, finely chopped",
            "2 tablespoons fresh thyme, finely chopped",
            "Salt and black pepper to taste",
            "1/4 cup soy sauce",
            "1/4 cup soy sauce"
            
        ],
        tags:  ["Chicken", "Salad"],
        steps:  [
            CookingStep(
                id: "1",
                context: "Begin by setting up your charcoal grill for indirect grilling. Fill a charcoal chimney starter with charcoal briquettes and light them. Once the coals are ashed over, pour them onto one side of the grill, creating a two-zone fire. Place a drip pan under the grill grate on the cool side.",
                backgroundURL: "soup",
                stepNumber: 1
            ),
            CookingStep(
                id: "2",
                context: "Cover the grill and allow it to preheat for about 10-15 minutes. Aim for a medium-high temperature of around 350-400°F (175-200°C).",
                backgroundURL: "soup",
                stepNumber: 2
            ),
            CookingStep(
                id: "3",
                context: "Trim any excess fat and silver skin from the beef tenderloin.\nIn a small bowl, mix together the olive oil, minced garlic, chopped rosemary, chopped thyme, salt, and black pepper.\nRub the mixture evenly over the entire surface of the beef tenderloin. Allow it to marinate for at least 30 minutes at room temperature.",
                backgroundURL: "soup",
                stepNumber: 3
            ),
            CookingStep(
                id: "4",
                context: "In a separate bowl, whisk together all the marinade ingredients until well combined.",
                backgroundURL: "soup",
                stepNumber: 4
            ),
            CookingStep(
                id: "5",
                context: "Place the marinated beef tenderloin in a large resealable plastic bag and pour the marinade over it. Seal the bag, removing as much air as possible, and refrigerate for at least 2 hours, or overnight for maximum flavor",
                backgroundURL: "soup",
                stepNumber: 5
            ),
        ],
        isSaved: true
    )
    
    static var sampleRecipeList: [Recipe] = Array(0...5).map { index in
        var newRecipe = sampleRecipe
        newRecipe.id = "\(index)"
        return newRecipe
    }
    
}


struct CookingStep: Identifiable, Codable {
    @DocumentID var id: String?
    var context: String
    var backgroundURL: String
    var stepNumber: Int
}

struct CookingStepInterface {
    var context: String
    var imageData: PhotosPickerItem? = nil
    var stepNumber: Int
}

struct NutritionItem: Identifiable {
    var id = UUID()
    var type: String
    var value: Int
}

struct updateRecipeInterface {
    var name: String? = nil
    var mealType: String? = nil
    var backgroundImage: PhotosPickerItem? = nil
    var intro: String? = nil
    var servingSize: Int? = nil
    var cookingTime: Int? = nil
    var calories: Int? = nil
    var carb: Int? = nil
    var protein: Int? = nil
    var fat: Int? = nil
    var sugars: Int? = nil
    var salt: Int? = nil
    var saturates: Int? = nil
    var fibre: Int? = nil
    var ingredients: [String]? = nil
    var tags: [String]? = nil
    var steps: [CookingStepInterface]? = nil
}




func getTagColor(tagValue: String) -> Color {
    switch tagValue {
    case "Breakfast":
        return Color.theme.LightBlueInstance
    case "Brunch":
        return Color.theme.GreenInstance
    case "Dinner":
        return Color.theme.LightOrangeInstance
    case "Chicken":
        return Color.theme.YellowInstance
    case "Beef":
        return Color.theme.RedInstance
    case "Pork":
        return Color.theme.RedInstance
    case "Eggs":
        return Color.theme.DarkBlueInstance
    case "Soup":
        return Color.theme.BlueInstance
        
    default:
        return Color.theme.GrayInstance
    }
    
}



