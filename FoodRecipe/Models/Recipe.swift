//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI
import PhotosUI

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    let creatorID: String
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
