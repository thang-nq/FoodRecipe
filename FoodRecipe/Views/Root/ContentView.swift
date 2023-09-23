//
//  ContentView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
//    @State var showLoading: Bool = true
    @State var isAuthenticate: Bool = false
    @AppStorage("initialView") var initialView: Bool = true
    
    var body: some View {
        Group {
//            if authVM.userSession != nil {
//                if authVM.currentUser != nil {
////                    HomeView()
//                    UserProfileView()
//                } else {
////                    LoginView()
//                    Progress(loadingSize: 4)
//
//
//                }
//
//            } else {
//                LoginView()
//            }
            
            if authVM.isAuthenticated {
                HomeView()
            } else {
                LoginView()
            }
        }
        .fullScreenCover(isPresented: $initialView, content: {
//            OnLoadingList(showLoading: $showLoading)
            OnLoadingList()

        })
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AuthViewModel())
//    }
//}
