//
//  Alert.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//


import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var buttonTitle: String
}
