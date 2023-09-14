//
//  Tag.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

struct TagView: View {
    var text: String
    var body: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .padding(4)
            .background(.clear)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.theme.LightOrange, lineWidth: 2)
            )
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Vegan")
    }
}
