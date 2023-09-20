//
//  TDEEWrapperView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 19/09/2023.
//

import SwiftUI

struct TDEEWrapperView: View {
    @State var isTDEECalculator: Bool = true
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Group {
            if let currentUser = authViewModel.currentUser {
                if currentUser.enableTDDE {
                    TDEEPersonalView()
                } else {
                    TDDEFormView()
                }
                
            } else{
                //                TDDEFormView()
                LoginView()
            }
        }
    }
}

//struct TDEEWrapperView_Previews: PreviewProvider {
//    static var previews: some View {
//        TDEEWrapperView()
//    }
//}
