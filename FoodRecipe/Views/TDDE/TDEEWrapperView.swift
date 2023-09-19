//
//  TDEEWrapperView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 19/09/2023.
//

import SwiftUI

struct TDEEWrapperView: View {
    @State var isTDEECalculator: Bool = true
    var body: some View {
        Group {
            if isTDEECalculator {
                TDEEPersonalView()
            } else{
                TDDEFormView()
            }
        }
    }
}

struct TDEEWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        TDEEWrapperView()
    }
}
