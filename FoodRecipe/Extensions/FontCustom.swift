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
    
    let Heading = Font.custom("ZillaSlab-Bold", size: 18)
    let ContentRegular = Font.custom("ZillaSlab-Regular", size: 16)
    let ContentItalic = Font.custom("ZillaSlab-MediumItalic", size: 16)
    let ButtonText = Font.custom("ZillaSlab-SemiBoldItalic", size: 20)

}
