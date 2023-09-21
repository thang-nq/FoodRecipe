//
//  SectionContainerView.swift
//  FoodRecipe
//
//  Created by Man Pham on 12/09/2023.
//

import SwiftUI


struct SectionContainerView<Content>: View where Content: View {
    @State private var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 16) {
            content()
        }
        .padding(16)
        .frame(width: .infinity, alignment: .top)
        .background(Color.theme.White)
        .cornerRadius(16)
    }
}

struct SectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("LightGray").ignoresSafeArea(.all)
            SectionContainerView() {
                Text("Nutritions")
            }
        }
    }
}
