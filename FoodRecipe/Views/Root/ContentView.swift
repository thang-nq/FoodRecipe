/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
//    @State var showLoading: Bool = true
    @State var isAuthenticate: Bool = false
    @AppStorage("initialView") var initialView: Bool = true
    
    var body: some View {
        Group {
            if authVM.isAuthenticated {
                HomeView()
            } else {
                LoginView()
            }
        }
        .fullScreenCover(isPresented: $initialView, content: {
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
