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


struct SectionContainerView<Content>: View where Content: View {
    @State private var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 16) {
            content()
        }
        .padding(16)
        .frame(width: .infinity, alignment: .top)
        .background(Color.theme.White)
        .cornerRadius(16)
    }
}

struct SectionContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("LightGray").ignoresSafeArea(.all)
            SectionContainerView() {
                Text("Nutritions")
            }
        }
    }
}
