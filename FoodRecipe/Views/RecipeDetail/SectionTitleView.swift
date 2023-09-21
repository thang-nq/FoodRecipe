//
//  SectionTitleView.swift
//  FoodRecipe
//
//  Created by Man Pham on 12/09/2023.
//

import SwiftUI

struct SectionTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.custom.Heading)
            .kerning(0.552)
            .foregroundColor(Color.theme.Black)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SectionTitleView(title: "Ingredients")
        }
    }
}
