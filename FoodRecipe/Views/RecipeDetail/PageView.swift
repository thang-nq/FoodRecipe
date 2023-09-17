//
//  PageView.swift
//  FoodRecipe
//
//  Created by Man Pham on 17/09/2023.
//

import SwiftUI

struct PageView: View {
    var page: Page
    var totalSteps: Int
    var body: some View {
        VStack(spacing: 0) {
            Image("soup")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 390)
                .clipped()
            VStack(alignment: .leading) {
                Text("Step \(page.tag + 1) of \(totalSteps)")
                    .font(.custom("ZillaSlab-Bold", size: 26)).fontWeight(.medium)
                    .kerning(0.552)
                    .foregroundColor(Color.theme.Orange)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text(page.description)
            }
            .padding()
            .frame(maxWidth: .infinity)
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage, totalSteps: 3)
    }
}
