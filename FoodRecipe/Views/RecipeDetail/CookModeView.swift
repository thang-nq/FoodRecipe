//
//  CookModeView.swift
//  FoodRecipe
//
//  Created by Man Pham on 16/09/2023.
//

import SwiftUI

struct CookModeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var recipe: Recipe
    @State var pageIndex = 0
    private func back() {
        // Back action
        self.presentationMode.wrappedValue.dismiss()
    }
    var pages: [Page] = Page.samplePages
    init(recipe: Recipe) {
        self.recipe = recipe
        self.pages = recipe.steps.enumerated().map { (index, element) in
            return Page(name: "Step \(index+1)", description: element.context, imageUrl: element.backgroundURL, tag: index)
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    // MARK: Page view
                    PageView(page: page, totalSteps: pages.count, incrementPage: incrementPage, decrementPage: decrementPage).tag(page.tag)
                }
            }
            
            
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .padding(.top, 50)
        .overlay(
            NavBar(title: "Cook Mode", leftIconName: "xmark", leftIconAction: back)
        )
    }
    
    func incrementPage() {
        if(pageIndex < pages.count - 1) {
            pageIndex += 1
        }else {
            pageIndex = 0
        }
    }
    
    func decrementPage() {
        if(pageIndex > 0) {
            pageIndex -= 1
        }else {
            pageIndex = pages.count - 1
        }
    }
}

struct CookModeView_Previews: PreviewProvider {
    static var previews: some View {
        CookModeView(
            recipe:  Recipe.sampleRecipe
        )
    }
}

struct Page: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(
        name: "Title example",
        description: "Make the dressing by blending all of the ingredients in a food processor (or very finely chop them), saving a few herb leaves for the salad. You can make the dressing up to 24 hrs before serving.",
        imageUrl: "https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/Minecraft%20(1).png",
        tag: 0
    )
    
    static var samplePages: [Page] = [
        Page(
            name: "Step 1",
            description: "Make the dressing by blending all of the ingredients in a food processor (or very finely chop them), saving a few herb leaves for the salad. You can make the dressing up to 24 hrs before serving.",
            imageUrl: "https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/Minecraft%20(1).png",
            tag: 0),
        
        Page(
            name: "Step 2",
            description: "Heat 1 tbsp olive oil in a large frying pan with a lid and brown 2 chopped chicken breasts for 5-8 mins until golden",
            imageUrl: "https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/Minecraft%20(1).png",
            tag: 1),
        
        Page(
            name: "Step 3",
            description: "Add 1 thinly sliced red pepper, 2 crushed garlic cloves, 75g sliced chorizo and 1 tbsp Cajun seasoning, and cook for 5 mins more.",
            imageUrl: "https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/Minecraft%20(1).png",
            tag: 2
        )
    ]
}

