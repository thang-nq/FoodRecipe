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
        }
        .background(Color.theme.White)
    }
}

//struct FilterSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterSheet()
//    }
//}
