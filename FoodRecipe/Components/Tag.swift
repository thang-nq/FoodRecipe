//
//  Tag.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

struct Tag: View {
    var text: String
    var tagColor: Color
    
    var body: some View {
        Text(text)
            .font(Font.custom.SubContent)
            .foregroundColor(Color.theme.WhiteInstance)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(tagColor)
            .cornerRadius(8)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(text: "Vegan", tagColor: Color.theme.GreenInstance)
    }
}
