/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Man Pham
  ID: s3804811
  Created  date: 13/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @AppStorage("isDarkMode") var isDark = false
    var action: () -> Void
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.Gray : Color.theme.Orange
                )
            TextField("Search for recipes", text: $searchText)
                .foregroundColor(Color.theme.Orange)
                .accentColor(Color.theme.Orange)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .padding()
                        .foregroundColor(Color.theme.Orange)
                        .offset(x: 10)
                        .onTapGesture {
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                .onSubmit {
                    action()
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(isDark ? Color.theme.DarkGray.opacity(0.1) : Color.theme.White)
                .shadow(
                    color: Color.theme.BlackInstance.opacity(0.1),
                    radius: 10, x: 0, y: 0
                )
        )
        //            .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), action: {})
    }
}
