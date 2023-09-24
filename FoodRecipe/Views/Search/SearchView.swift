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


var MOCK_TAGS = ["chicken", "soup", "rice", "pork", "sandwich", "eggs", "duck", "avocado", "simple", "milk"]
var MOCK_MEAL_TYPES = ["breakfast", "brunch", "lunch", "dinner", "snack"]

struct SearchView: View {
    @State var currentSelectedTags: [String] = []
    @State var currentSelectedMealTypes: [String] = []
    //    @State var searchInput = ""
    @State var showingSheet: Bool = false
    @StateObject var viewModel = SearchViewModel()
    @AppStorage("isDarkMode") var isDark = false
    
    func searchAction() {
        Task {
            await viewModel.searchRecipeByText()
        }
    }
    
    func searchByTag() {
        Task {
            await viewModel.searchRecipeByTags(tags: viewModel.currentSelectedTags + viewModel.currentSelectedMealTypes)
        }
    }
    var body: some View {
        // MARK: Main
        VStack(spacing: 10){
            SearchBar(searchText: $viewModel.searchString, action: searchAction)
            HStack(alignment: .center, spacing: 17) {
                // MARK: Filter bar
                Button {
                    showingSheet.toggle()
                } label: {
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(isDark ? Color.theme.WhiteInstance : Color.theme.DarkGray)
                            .font(.custom.Content)
                        
                        Text("Filter")
                            .foregroundColor(isDark ? Color.theme.WhiteInstance : Color.theme.DarkGray)
                            .font(.custom.Content)
                        
                    }
                    .padding(0)
                }.sheet(isPresented: $showingSheet) {
                    // MARK: Sheet View
                    ZStack {
                        if isDark {
                            Color("DarkGray").opacity(0.1).ignoresSafeArea(.all)
                        }
                        VStack {
                            FilterSheet(currentSelectedTags: $currentSelectedTags, currentSelectedMealTypes: $currentSelectedMealTypes, selectMealType: selectMealType, selectTag: selectTag)
                            saveButton
                        }
                        .presentationDetents([.medium, .large]).environment(\.colorScheme, isDark ? .dark : .light)
                    }.background(Color.theme.White.ignoresSafeArea(.all)).environment(\.colorScheme, isDark ? .dark : .light)
                }
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: 50)
                    .background(isDark ? Color.theme.DarkGray : Color(red: 0.88, green: 0.89, blue: 0.89))
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(currentSelectedMealTypes + currentSelectedTags, id: \.self) { selected in
                            Button {
                                //                            action(text)
                                print(selected)
                            } label: {
                                HStack {
                                    Text(selected.capitalized)
                                        .font(.custom.Content)
                                    Image(systemName: "minus").font(.custom.Content)
                                    
                                }
                                .padding(3)
                                .background(Color.theme.LightOrange)
                                .foregroundColor(Color.theme.WhiteInstance)
                                .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 0)
            .frame(width: 375, height: 50, alignment: .leading)
            .background(Color.theme.White)
            .shadow(color: isDark ? Color.theme.DarkGray : Color.theme.Black.opacity(0.1), radius: 0, x: 0, y: 1)
            
            
            ScrollView {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: {} ).navigationBarHidden(true)) {
                        RecipeCardView(recipe: recipe, hideSave: true)
                    }
                }
            }.padding(10)
            
            
            Spacer()
        }.padding(10).environment(\.colorScheme, isDark ? .dark : .light)
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
                viewModel.currentSelectedTags = currentSelectedTags
            }
        } else {
            currentSelectedTags.append(tag)
            viewModel.currentSelectedTags = currentSelectedTags
        }
    }
    func selectMealType(tag: String) {
        if(currentSelectedMealTypes.contains(tag)) {
            if let index = currentSelectedMealTypes.firstIndex(of: tag) {
                currentSelectedMealTypes.remove(at: index)
                viewModel.currentSelectedMealTypes = currentSelectedMealTypes
            }
        } else {
            currentSelectedMealTypes.append(tag)
            viewModel.currentSelectedMealTypes = currentSelectedMealTypes
        }
    }
}

private extension SearchView {
    var saveButton: some View {
        Button {
            if(viewModel.searchString.count > 0) {
                searchAction()
            }else {
                searchByTag()
            }
            showingSheet.toggle()
        } label: {
            //                            Text("Helo")
            Text("Search")
                .font(Font.custom.ButtonText)
                .frame(width: 350, height: 50)
                .contentShape(Rectangle())
        }
        .foregroundColor(Color.theme.WhiteInstance)
        .background(Color.theme.Orange)
        .cornerRadius(8)
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
    @AppStorage("isDarkMode") var isDark = false
    
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
        } label: {
            HStack {
                Text(text.capitalized)
                    .font(.custom.Content)
                Image(systemName: isSelect ? "checkmark" : "plus").font(.custom.Content)
                
            }
            .padding(3)
            .background(isSelect ? Color.theme.LightOrange : (isDark ? Color.theme.DarkGray.opacity(0.5) : Color.theme.LightGray))
            .foregroundColor(isSelect ? Color.theme.WhiteInstance : (isDark ? Color.theme.WhiteInstance.opacity(1) : Color.theme.DarkGray))
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
