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
