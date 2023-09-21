//
//  FilterSheet.swift
//  FoodRecipe
//
//  Created by Man Pham on 21/09/2023.
//

import SwiftUI

struct FilterSheet: View {
    @Binding var currentSelectedTags: [String]
    @Binding var currentSelectedMealTypes: [String]
    var selectMealType: (String) -> Void
    var selectTag: (String) -> Void
    @AppStorage("isDarkMode") var isDark = false
    var body: some View {
        ZStack {
            if isDark {
                Color("DarkGray").opacity(0.1).ignoresSafeArea(.all)
            }
            VStack {
                SectionTitleView(title: "Meal types")
                TagsFilterView(tags: MOCK_MEAL_TYPES, currentSelectedTags: $currentSelectedMealTypes, action: selectMealType)
                SectionTitleView(title: "Tags")
                TagsFilterView(tags: MOCK_TAGS, currentSelectedTags: $currentSelectedTags, action: selectTag)
                Spacer()
            }
            //            .background(Color.theme.DarkGray.opacity(0.1))
            .padding(10)
        }.background(Color.theme.White)
    }
}

//struct FilterSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterSheet()
//    }
//}
