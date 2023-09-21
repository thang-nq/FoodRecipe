//
//  TDEEWrapperView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 19/09/2023.
//

import SwiftUI

struct TDEEWrapperView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if let currentUser = UserManager.shared.currentUser {
                if currentUser.enableTDDE {
                    TDEEPersonalView()
                } else {
//                    TDDEFormView()
                    TDEEPersonalView()
                }

            }
        }
    }
}
