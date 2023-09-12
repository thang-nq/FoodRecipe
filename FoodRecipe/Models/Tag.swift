//
//  Tag.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//

import Foundation
struct Tag: Identifiable, Codable {
    let id: String
    var name: String
    var tagValue: String
}
