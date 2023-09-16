//
//  TestProgress.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import SwiftUI

struct TestProgress: View {
    var body: some View {
        ZStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.OrangeInstance))
                .scaleEffect(3)
            
        }
        
    }
}

struct TestProgress_Previews: PreviewProvider {
    static var previews: some View {
        TestProgress()
    }
}
