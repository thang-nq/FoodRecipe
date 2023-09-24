/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Man Pham
  ID: s3804811
  Created  date: 17/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct NavBar: View {
    var title: String
    var leftIconName: String?
    var leftIconAction: () -> Void = {}
    var body: some View {
        ZStack {
            Color.clear
                .background(Color.theme.Orange)
            HStack {
                if let leftIconNameUnwrapped = leftIconName {
                    Button {
                        leftIconAction()
                    } label: {
                        Image(systemName: leftIconNameUnwrapped).font(.custom.Heading).foregroundColor(Color.theme.WhiteInstance)
                    }
                }
                
                Text(title)
                    .foregroundColor(Color.theme.WhiteInstance)
                    .font(.custom.NavigationTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.horizontal, 10)
        }
        .frame(height: 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(title: "Featured", leftIconName: "xmark")
    }
}
