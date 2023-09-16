//
//  RecipeDetailView.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI
import SlidingTabView

struct RecipeDetailView: View {
    var recipeId: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var detailVM = RecipeDetailViewModel()
    @State private var selectedTabIndex = 0
    func back() {
        // Back action
        self.presentationMode.wrappedValue.dismiss()
    }
    var body: some View {
        ScrollView {
            VStack {
                if let recipeDetail = detailVM.recipe {
                    ZStack(alignment: .top) {
                        Color("LightGray")
                        // MARK: Overlay Image
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: .infinity, height: 408)
                            .background(
                                FirebaseImage(imagePathName: recipeDetail.backgroundURL)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: .infinity,height: 408)
                                    .clipped()
                            )
                            .offset(y: -60)
                        
                        TopBar(action: back)
                        //                    if let recipeDetail = detailVM.recipe {
                        VStack(spacing: 15) {
                            ZStack {
                                VStack(spacing: 15) {
                                    MainInfo(recipe: recipeDetail)
                                    NutritionView(recipe: recipeDetail)
                                }
                            }
                            VStack {
                                SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
                                if selectedTabIndex == 0 {
                                    SectionContainerView {
                                        Text(recipeDetail.intro)
                                            .font(.custom("ZillaSlab-Regular", size: 20))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    }
                                }
                                if selectedTabIndex == 1 {
                                    IngredientsView(ingredientsList: recipeDetail.ingredients)
                                }
                                
                                if selectedTabIndex == 2 {
                                    StepsView(stepsList: recipeDetail.steps)
                                }
                            }.background(Color.theme.White)
                        }
                        
                    }
                }
            }
        }.onAppear {
            Task(priority: .medium) {
                do {
                    try await detailVM.getRecipeDetail(recipeID: recipeId)
                    if let recipe = detailVM.recipe {
                        print(recipe.name)
                    }
                } catch {
                    // Handle any errors that occur during the async operation
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipeId: "GAHWzx1LuKetTSE44Ica")
    }
}


struct TopBar: View {
    var action: () -> Void
    var body: some View {
        HStack  {
            Button {
                action()
            } label: {
                
                Image("chevron-left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
            }
            
            
            Spacer()
            Image("heart-orange")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(10)
                .background(.white)
                .clipShape(Circle())
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 25)
    }
}

struct MainInfo: View {
    let recipe: Recipe
    var body: some View {
        //    return SectionContainerView {
        SectionContainerView {
            Text(recipe.name)
                .font(.custom("ZillaSlab-BoldItalic", size: 26)).fontWeight(.medium)
                .kerning(0.552)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            HStack {
                TagView(text: recipe.mealType)
                ForEach(recipe.tags, id: \.self) { tag in
                    TagView(text: tag)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("By ") + Text("**Nick Tran**").font(.custom("ZillaSlab-BoldItalic", size: 20)).fontWeight(.medium)
                Spacer()
                Text("September 1st, 2023")
            }
            Divider()
            Text(recipe.intro)
                .font(.custom("ZillaSlab-Regular", size: 20))
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.top, 300)
        .padding(.horizontal, 25)
        .padding(.bottom, -300)
        .zIndex(100)
    }
    
}
