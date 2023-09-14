//
//  ContentView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State var showLoading: Bool = false
    
    var body: some View {
        Group {
            if authVM.userSession != nil {
                UserProfileView()
            } else {
                LoginView()
                    .onAppear {
                        showLoading = true
                    }
                
            }
        }
        .fullScreenCover(isPresented: $showLoading, content: {
            OnLoadingList(showLoading: $showLoading)
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
