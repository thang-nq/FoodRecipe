//
//  Color.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 11/09/2023.
//

import Foundation
import SwiftUI

// config theme color using in application
// these color directly interact with light/dark mode element

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    
    // MARK: ACCENT COLORS
    let Black = Color("Black")
    let Blue = Color("Blue")
    let DarkBlue = Color("DarkBlue")
    let DarkGray = Color("DarkGray")
    let DarkWhite = Color("DarkWhite")
    let Gray = Color("Gray")
    let LightBlue = Color("LightBlue")
    let LightGray = Color("LightGray")
    let LightOrange = Color("LightOrange")
    let Orange = Color("Orange")
    let White = Color("White")
    
    //MARK: INSTANCE COLORS
    let BlackInstance = Color("BlackInstance")
    let BlueInstance = Color("BlueInstance")
    let DarkBlueInstance = Color("DarkBlueInstance")
    let DarkGrayInstance = Color("DarkGrayInstance")
    let DarkWhiteInstance = Color("DarkWhiteInstance")
    let GrayInstance = Color("GrayInstance")
    let LightBlueInstance = Color("LightBlueInstance")
    let LightGrayInstance = Color("LightGrayInstance")
    let LightOrangeInstance = Color("LightOrangeInstance")
    let OrangeInstance = Color("OrangeInstance")
    let WhiteInstance = Color("WhiteInstance")
    let RedInstance = Color("RedInstance")
    let GreenInstance = Color("GreenInstance")
    let YellowInstance = Color("YellowInstance")
    
    //MARK: TAB VIEW COLOR
    
    let TabBarColor = Color("TabBarColor")
    let UnTintColor = Color("UnTintColor")

}
