//
//  Font.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 20/09/2023.

import Foundation
import SwiftUI

extension Font {
    static let custom = FontCustom()
    
}

struct FontCustom {

    
    let NavigationTitle = Font.custom("ZillaSlab-Bold", size: 30)
    let NavigationTitleItalic = Font.custom("ZillaSlab-BoldItalic", size: 30)
    
    let Heading = Font.custom("ZillaSlab-SemiBold", size: 24)
    let HeadingItalic = Font.custom("ZillaSlab-SemiBoldItalic", size: 24)
    
    let SubHeading = Font.custom("ZillaSlab-SemiBold", size: 20)
    let SubHeadingItalic = Font.custom("ZillaSlab-SemiBoldItalic", size: 20)
    
    let Content = Font.custom("ZillaSlab-Regular", size: 16)
    let ContentItalic = Font.custom("ZillaSlab-MediumItalic", size: 16)
    
    let SubContent = Font.custom("ZillaSlab-Regular", size: 14)
    let SubContentItalic = Font.custom("ZillaSlab-MediumItalic", size: 14)
    
    
    //MARK: COMPONENT STYLE
    let ButtonText = Font.custom("ZillaSlab-SemiBold", size: 20)

}
