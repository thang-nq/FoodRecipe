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
        self.pages = recipe.steps.map { Page(name: "Step \($0.stepNumber)", description: $0.context, imageUrl: $0.backgroundURL, tag: $0.stepNumber - 1)}
    }
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    PageView(page: page, totalSteps: pages.count).tag(page.tag)
                }
            }
            .overlay(
                HStack {
                    Button {
                        decrementPage()
                    } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.theme.WhiteInstance)
                        .padding(10)
                        .background(Color.theme.Orange)
                        .clipShape(Circle())
                    }

                    Spacer()
                    Button {
                        incrementPage()
                    } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.theme.Orange)
                        .clipShape(Circle())
                    }

                }.padding(.horizontal, 20),
                alignment: .bottom
            )
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            
        }
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

