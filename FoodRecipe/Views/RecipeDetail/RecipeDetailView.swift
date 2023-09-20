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
    var onDissappear: () -> Void
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var detailVM = RecipeDetailViewModel()
    @State private var selectedTabIndex = 0
    private func back() {
        // Back action
        self.presentationMode.wrappedValue.dismiss()
    }
    private func saveAction() {
        Task {
            await detailVM.saveOrReomveSavedRecipe(recipeID: recipeId)
        }
    }
    var body: some View {
        NavigationView {
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
                                        .frame(minWidth: 408, maxHeight: 408)
                                        .clipped()
                                )
                                .offset(y: -60)
                            
                            TopBar(recipeId: recipeId, isSaved: recipeDetail.isSaved, backAction: back, saveAction: saveAction)
                            
                            // MARK: Content
                            VStack(spacing: 15) {
                                ZStack {
                                    VStack(spacing: 15) {
                                        // MARK: MainInfo
                                        MainInfo(recipe: recipeDetail)
                                        // MARK: Nutrition
                                        NutritionView(recipe: recipeDetail)
                                    }
                                }
                                VStack {
                                    // MARK: Sliding tab views
                                    SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
                                    if selectedTabIndex == 0 {
                                        // Intro
                                        SectionContainerView {
                                            Text(recipeDetail.intro)
                                                .font(.custom("ZillaSlab-Regular", size: 20))
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                        }
                                    }
                                    if selectedTabIndex == 1 {
                                        // Ingredients
                                        IngredientsView(ingredientsList: recipeDetail.ingredients)
                                    }
                                    
                                    if selectedTabIndex == 2 {
                                        // Steps
                                        StepsView(stepsList: recipeDetail.steps)
                                    }
                                }.background(Color.theme.WhiteInstance).frame(minHeight: 300)
                            }
                            
                        }
                    }
                }
            }.overlay(
                HStack {
                    if let recipeDetail = detailVM.recipe {
                        NavigationLink(destination: CookModeView(recipe: recipeDetail)) {
                            Image(systemName: "flame")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.theme.Orange)
                                .clipShape(Circle())
                        }
                    }
                }.padding(15),
                
                alignment: .bottomTrailing
            )
            .onAppear {
                Task(priority: .medium) {
                    do {
                        try await detailVM.getRecipeDetail(recipeID: recipeId)
                        if let recipe = detailVM.recipe {
                        }else {
                            detailVM.getMockRecipeDetail()
                        }
                    } catch {
                        // Handle any errors that occur during the async operation
                        print("Error: \(error)")
                    }
                }
            }
            .onDisappear {
                onDissappear()
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipeId: "QemaUoPfXPDMThjSF3og", onDissappear: {})
    }
}


// MARK: TopBar
struct TopBar: View {
    var recipeId: String
    var isSaved: Bool
    var backAction: () -> Void
    var saveAction: () -> Void
    var body: some View {
        HStack  {
            Button {
                backAction()
            } label: {
                // Back button
                Image("chevron-left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.Black.opacity(0.5))
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
            }
            
            
            Spacer()
            
            Button {
                saveAction()
            } label: {
                // Save recipe
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSaved ? Color.theme.WhiteInstance : Color.theme.Black.opacity(0.5))
                    .padding(10)
                    .background(isSaved ? Color.theme.Orange : .white)
                    .clipShape(Circle())
            }
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 25)
    }
}

// MARK: MainInfo
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
                Tag(text: recipe.mealType)
                ForEach(recipe.tags, id: \.self) { tag in
                    Tag(text: tag)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("By ") + Text("**\(recipe.creatorName)**").font(.custom("ZillaSlab-BoldItalic", size: 20)).fontWeight(.medium)
                Spacer()
                Text(recipe.createdAt)
            }
            HStack(alignment: .center, spacing: 16) {
                VStack(spacing: 8) {
                    Image(systemName: "clock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.theme.Orange)
                        .frame(width: 24, height: 24)
                    Text("\(recipe.cookingTime) minutes")
                }.frame(maxWidth: .infinity)
                //                Divider()
                //                Rectangle().fill(.blue).frame(width: 1) // or any other color
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: 70)
                    .background(Color.theme.Black.opacity(0.3))
                
                VStack(spacing: 8){
                    Image(systemName: "fork.knife")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.theme.Orange)
                        .frame(width: 24, height: 24)
                    Text("Serves \(recipe.servingSize)")
                }.frame(maxWidth: .infinity)
            }.padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.white)
                .shadow(color: Color.theme.Black.opacity(0.3), radius: 0, x: 0, y: -1)
//                .shadow(color: Color.theme.Black.opacity(0.3), radius: 0, x: 0, y: 1)
//            Text(recipe.intro)
//                .font(.custom("ZillaSlab-Regular", size: 20))
//                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.top, 300)
        .padding(.horizontal, 25)
        .padding(.bottom, -300)
        .zIndex(100)
    }
    
}
