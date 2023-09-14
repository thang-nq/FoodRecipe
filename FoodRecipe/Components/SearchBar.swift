//
//  SearchBar.swift
//  FoodRecipe
//
//  Created by Man Pham on 13/09/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
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
        }.font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(
                        color: Color.theme.Black.opacity(0.1),
                        radius: 10, x: 0, y: 0
                    )
            )
//            .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
