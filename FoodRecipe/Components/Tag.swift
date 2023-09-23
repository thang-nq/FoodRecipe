//
//  Tag.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

//MARK: COMPONENT TAG PRESENT FOR RECIPE
struct Tag: View {
    var text: String
    var tagColor: Color
    
    var body: some View {
        // Display the provided text with a custom font
        Text(text)
            .font(Font.custom.SubContent) // Apply custom font
            .foregroundColor(Color.theme.DarkBlueInstance)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(tagColor) // Set the background color based on the provided tagColor
            .cornerRadius(8) // Apply rounded corners to the view
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(text: "Vegan", tagColor: Color.theme.GreenInstance)
    }
}
