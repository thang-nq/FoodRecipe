/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 10/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
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
