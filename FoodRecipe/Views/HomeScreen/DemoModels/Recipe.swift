//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var description : String
    var tag: String
}
