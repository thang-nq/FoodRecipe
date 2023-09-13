//
//  SearchView.swift
//  FoodRecipe
//
//  Created by Man Pham on 13/09/2023.
//

import SwiftUI


var MOCK_TAGS = ["chicken", "soup", "rice", "pork", "sandwich", "eggs", "duck", "avocado", "simple", "milk"]
var MOCK_MEAL_TYPES = ["breakfast", "brunch", "lunch", "dinner", "snack"]

struct SearchView: View {
    @State var currentSelectedTags: [String] = []
    @State var currentSelectedMealTypes: [String] = []
    @State var searchInput = ""
    var body: some View {
        // MARK: Main
        VStack(spacing: 10){
            SearchBar(searchText: $searchInput)
            SectionTitleView(title: "Meal types")
            TagsFilterView(tags: MOCK_MEAL_TYPES, currentSelectedTags: $currentSelectedMealTypes, action: selectMealType)
            SectionTitleView(title: "Tags")
            TagsFilterView(tags: MOCK_TAGS, currentSelectedTags: $currentSelectedTags, action: selectTag)
            Spacer()
        }.padding(10)
    }
    func selectTag(tag: String) {
        if(currentSelectedTags.contains(tag)) {
            if let index = currentSelectedTags.firstIndex(of: tag) {
                currentSelectedTags.remove(at: index)
            }
        } else {
            currentSelectedTags.append(tag)
        }
    }
    func selectMealType(tag: String) {
        if(currentSelectedMealTypes.contains(tag)) {
            if let index = currentSelectedMealTypes.firstIndex(of: tag) {
                currentSelectedMealTypes.remove(at: index)
            }
        } else {
            currentSelectedMealTypes.append(tag)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct TagsFilterView: View {
    var tags: [String]
    @Binding var currentSelectedTags: [String]
    var action: (String) -> Void
    
    @State private var totalHeight
    = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some View {
        let isSelect = currentSelectedTags.contains(text)
        return Button {
            action(text)
            print(currentSelectedTags)
        } label: {
            HStack {
                Text(text.capitalized)
                    .font(.body)
                Image(systemName: isSelect ? "checkmark" : "plus").font(.system(size: 15))
                
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 5)
            .background(isSelect ? Color.theme.LightOrange : Color.theme.LightGray)
            .foregroundColor(isSelect ? Color.theme.White : Color.theme.DarkGray)
            .cornerRadius(5)
        }
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
