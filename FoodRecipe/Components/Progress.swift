//
//  Progress.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import SwiftUI

struct Progress: View {
    var body: some View {
            ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.OrangeInstance))
            .scaleEffect(3)
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        Progress()
    }
}
