//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    let creatorUID: String
    var mealType: String = "Breakfast"
    var backgroundURL: String = ""
    var intro: String = ""
    var calories: Int = 300
    var carb: Int = 0
    var protein: Int = 0
    var fat: Int = 0
    var sugars: Int = 0
    var salt: Int = 0
    var saturates: Int = 0
    var fibre: Int = 0
    var tags: [String] = ["Chicken", "Salad"]
    var steps: [CookingStep] = []

}

struct CookingStep: Identifiable, Codable {
    @DocumentID var id: String?
    var context: String
    var imageURL: String
}
