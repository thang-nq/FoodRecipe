//
//  NavBar.swift
//  FoodRecipe
//
//  Created by Man Pham on 17/09/2023.
//

import SwiftUI

struct NavBar: View {
    var title: String
    var body: some View {
        ZStack {
            Color.clear
                .background(Color.theme.Orange)
            Text(title)
                .foregroundColor(Color.theme.WhiteInstance)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
        }
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(title: "Featured")
    }
}
