/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import Foundation
import SwiftUI

// Extend the Font struct to include custom fonts
extension Font {
    // Define a custom font named 'custom'
    static let custom = FontCustom()
}

// Create a struct to store custom font styles
struct FontCustom {
    
    //  Navigation title style
    let NavigationTitle = Font.custom("ZillaSlab-Bold", size: 30)
    let NavigationTitleItalic = Font.custom("ZillaSlab-BoldItalic", size: 30)
    
    // Heading font style
    let Heading = Font.custom("ZillaSlab-SemiBold", size: 24)
    let HeadingItalic = Font.custom("ZillaSlab-SemiBoldItalic", size: 24)
    
    // Subheading font style
    let SubHeading = Font.custom("ZillaSlab-SemiBold", size: 20)
    let SubHeadingItalic = Font.custom("ZillaSlab-SemiBoldItalic", size: 20)
    
    // Content font style
    let Content = Font.custom("ZillaSlab-Regular", size: 16)
    let ContentItalic = Font.custom("ZillaSlab-MediumItalic", size: 16)
    let ContentBold = Font.custom("ZillaSlab-Bold", size: 16)
    
    // Subcontent font style
    let SubContent = Font.custom("ZillaSlab-Regular", size: 14)
    let SubContentItalic = Font.custom("ZillaSlab-MediumItalic", size: 14)
    
    //MARK: COMPONENT STYLE
    // Component style font for buttons with a size of 20
    let ButtonText = Font.custom("ZillaSlab-SemiBold", size: 20)

}
