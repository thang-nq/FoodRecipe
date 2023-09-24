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

struct PageView: View {
    var page: Page
    var totalSteps: Int
    var incrementPage: () -> Void
    var decrementPage: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                FirebaseImage(imagePathName: page.imageUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 390)
                    .clipped()
            }.overlay(
                HStack {
                    Button {
                        decrementPage()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.theme.WhiteInstance.opacity(0.6))
                            .padding(10)
                            .background(Color.theme.BlackInstance.opacity(0.3))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    Button {
                        incrementPage()
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.theme.WhiteInstance.opacity(0.6))
                            .padding(10)
                            .background(Color.theme.BlackInstance.opacity(0.3))
                            .clipShape(Circle())
                    }
                    
                }.padding(10),
                alignment: .center
            )
            VStack(alignment: .leading) {
                Text("Step \(page.tag + 1) of \(totalSteps)")
                    .font(.custom.Heading)
                    .kerning(0.552)
                    .foregroundColor(Color.theme.Orange)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text(page.description).font(.custom.Content)
            }
            .padding()
            .frame(maxWidth: .infinity)
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage, totalSteps: 3, incrementPage: {}, decrementPage: {})
    }
}
