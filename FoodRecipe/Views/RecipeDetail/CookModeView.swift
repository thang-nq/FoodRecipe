//
//  CookModeView.swift
//  FoodRecipe
//
//  Created by Man Pham on 16/09/2023.
//

import SwiftUI

struct CookModeView: View {
    var recipe: Recipe
    @State var pageIndex = 0
    var pages: [Page] = Page.samplePages
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
//                    Spacer()
                    PageView(page: page, incrementPage: incrementPage).tag(page.tag)
                    

                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            
        }
        .padding(.top, 50)
        .overlay(
            NavBar(title: "Cook Mode")
        )
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func decrementPage() {
        pageIndex -= 1
    }
}

struct CookModeView_Previews: PreviewProvider {
    static var previews: some View {
        CookModeView(
            recipe: Recipe(name: "Crispy Pork",
                           creatorID: "randomid",
                           intro: "This is a healthy dish",
                           servingSize: 3,
                           cookingTime: 90,
                           calories: 740,
                           carb: 15,
                           protein: 30,
                           ingredients: ["300g Pork", "20g Salt"],
                           tags: ["Pork", "Dinner"])
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

