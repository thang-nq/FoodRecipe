//
//  SearchView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import SwiftUI

struct SearchView: View {
    @AppStorage("isDarkMode") var isDark = false
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isDark.toggle() }) {
                        isDark ? Label("Dark", systemImage: "lightbulb.fill") :
                        Label("Dark", systemImage: "lightbulb")
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        // Handle profile button action
//                    }) {
//                        Image("user")
//                    }
//                }
            }
        }.environment(\.colorScheme, isDark ? .dark : .light)
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
