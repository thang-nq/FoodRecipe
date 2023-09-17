//
//  testView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 17/09/2023.
//

import SwiftUI

struct testView: View {
    
    //MARK: FIX LATTER
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = false
    
    var body: some View {
        ZStack{
            TDDEFormView()
        }
        .fullScreenCover(isPresented: $TDDEIntro, content: {TDEEWelcomeList()})
        
    }
    
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
