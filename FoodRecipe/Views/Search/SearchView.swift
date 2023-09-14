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
    @State var showingSheet: Bool = false
    var body: some View {
        // MARK: Main
        VStack(spacing: 10){
            SearchBar(searchText: $searchInput)
            HStack(alignment: .center, spacing: 27) {
                // MARK: Filter bar
                Button {
                    showingSheet.toggle()
                } label: {
                    HStack(alignment: .center, spacing: 14) {
                        Image(systemName: "slider.horizontal.3").foregroundColor(Color.theme.DarkGray)
                        Text("Filter")
                            .foregroundColor(Color.theme.DarkGray)
                        .font(.custom("ZillaSlab-Regular", size: 20))                }
                    .padding(0)
                }.sheet(isPresented: $showingSheet) {
                    // MARK: Sheet View
                    FilterSheet(currentSelectedTags: $currentSelectedTags, currentSelectedMealTypes: $currentSelectedMealTypes, selectMealType: selectMealType, selectTag: selectTag)
                        .presentationDetents([.medium, .large])
                }
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: 50)
                    .background(Color(red: 0.88, green: 0.89, blue: 0.89))
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(currentSelectedMealTypes + currentSelectedTags, id: \.self) { selected in
                            Button {
                                //                            action(text)
                                print(selected)
                            } label: {
                                HStack {
                                    Text(selected.capitalized)
                                        .font(.body)
                                    Image(systemName: "minus").font(.system(size: 15))
                                    
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 5)
                                .background(Color.theme.LightOrange)
                                .foregroundColor(Color.theme.White)
                                .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 0)
            .frame(width: 375, height: 50, alignment: .leading)
            .background(.white)
            .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 1)
            Spacer()
        }.padding(10)
    }
    
    
//    func selectFilter(tag: String) {
//        if(currentSelectedFilters.contains(tag)) {
//            if let index = currentSelectedFilters.firstIndex(of: tag) {
//                currentSelectedFilters.remove(at: index)
//            }
//        } else {
//            currentSelectedFilters.append(tag)
//        }
//    }
    
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


struct FilterSheet: View {
    @Binding var currentSelectedTags: [String]
    @Binding var currentSelectedMealTypes: [String]
    var selectMealType: (String) -> Void
    var selectTag: (String) -> Void
    var body: some View {
        ZStack {
            VStack {
                SectionTitleView(title: "Meal types")
                TagsFilterView(tags: MOCK_MEAL_TYPES, currentSelectedTags: $currentSelectedMealTypes, action: selectMealType)
                SectionTitleView(title: "Tags")
                TagsFilterView(tags: MOCK_TAGS, currentSelectedTags: $currentSelectedTags, action: selectTag)
                Spacer()
            }.padding(10)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

// MARK: Component for render wrapping HStack
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
