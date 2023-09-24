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

struct SectionTitleView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.custom.Heading)
            .foregroundColor(Color.theme.Black)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SectionTitleView(title: "Ingredients")
        }
    }
}
