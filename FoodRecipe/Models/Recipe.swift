//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//

import Foundation


struct Recipe: Identifiable, Codable {
    let id: String
    var name: String
    let creatorUID: String
    var backgroundURL: String = ""
    var steps: String
//    var tags: [Tag] = []
}
