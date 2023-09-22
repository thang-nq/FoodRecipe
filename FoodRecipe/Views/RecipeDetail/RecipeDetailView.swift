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
    @AppStorage("isDarkMode") var isDark = false
    @State private var selectedTabIndex = 0
    @State var userId = UserManager.shared.currentUser!.id
    @State private var creatorId = ""
    @State private var isCreator = false
    @StateObject var tdde = TDDEViewModel.shared
    
    private func back() {
        // Back action
        self.presentationMode.wrappedValue.dismiss()
    }
    private func saveAction() {
        Task {
            await detailVM.saveOrReomveSavedRecipe(recipeID: recipeId)
        }
    }
    func checkCreator() async{
        if let recipeDetail = detailVM.recipe{
            if(userId == recipeDetail.creatorID){
                isCreator = true
            }
        }
    }
    
    func addToTDDE() {
        Task {
            await tdde.addRecipeToTDDE(recipeID: recipeId)
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        if let recipeDetail = detailVM.recipe {
                            ZStack(alignment: .top) {
                                if(isDark) {
                                    Color("DarkGray").opacity(0.1)
                                } else {
                                    Color("LightGray")
                                }
                                
                                
                                // MARK: Overlay Image
                                CoverImage(recipeDetail: recipeDetail)
                                
                                TopBar(isCreator: isCreator,recipeId: recipeId, isSaved: recipeDetail.isSaved, backAction: back, saveAction: saveAction, addToListAction: addToTDDE)
                                                                
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
                                        SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom.SubHeading,  activeAccentColor: Color.theme.Orange, inactiveAccentColor: Color.theme.Black, selectionBarColor: Color.theme.Orange)
                                        if selectedTabIndex == 0 {
                                            // Intro
                                            SectionContainerView {
                                                Text(recipeDetail.intro)
                                                    .font(.custom.Content)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                            }.padding(.horizontal, 10).padding(.vertical, 0)
                                        }
                                        if selectedTabIndex == 1 {
                                            // Ingredients
                                            IngredientsView(ingredientsList: recipeDetail.ingredients)
                                        }
                                        
                                        if selectedTabIndex == 2 {
                                            // Steps
                                            StepsView(stepsList: recipeDetail.steps)
                                        }
                                    }.background(Color.theme.White).frame(minHeight: 300)
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
                                // Handle the recipe data
                            } else {
                                detailVM.getMockRecipeDetail()
                            }
                        } catch {
                            // Handle any errors that occur during the async operation
                            print("Error: \(error)")
                        }
                        
                        await checkCreator()
                    }
                }
                .onDisappear {
                    onDissappear()
                }
            }
            // MARK: CHECK LOADING
            if (detailVM.isLoading == true){
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .background(Color.clear)
                    
                    Progress(loadingSize: 3)
                }
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
    var isCreator : Bool
    var recipeId: String
    var isSaved: Bool
    var backAction: () -> Void
    var saveAction: () -> Void
    var addToListAction: () -> Void
    var body: some View {
        HStack  {
            Button {
                backAction()
            } label: {
                // Back button
                Image("chevron-left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.BlackInstance.opacity(0.5))
                    .padding(10)
                    .background(Color.theme.WhiteInstance)
                    .clipShape(Circle())
            }
            

            Spacer()
            
            // Add to recipe list button
            Button {
                addToListAction()
            } label: {
                Image(systemName: "fork.knife")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.BlueInstance)
                    .padding(10)
                    .background(Color.theme.WhiteInstance)
                    .clipShape(Circle())
            }
            if(isCreator == true){
                NavigationLink(destination: UpdateRecipeView(recipeId: recipeId)) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.theme.BlackInstance.opacity(0.5))
                        .padding(10)
                        .background(Color.theme.WhiteInstance)
                        .clipShape(Circle())
                }
            }
            
            
            Button {
                saveAction()
            } label: {
                // Save recipe
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSaved ? Color.theme.WhiteInstance : Color.theme.BlackInstance.opacity(0.5))
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
        SectionContainerView {
            Text(recipe.name)
                .font(.custom.Heading)
                .foregroundColor(Color.theme.Black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            HStack {
                Tag(text: recipe.mealType, tagColor: Color.theme.BlueInstance)
                ForEach(recipe.tags, id: \.self) { tag in
                    Tag(text: tag, tagColor: Color.theme.Orange)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("By ").font(.custom.Content) + Text("\(recipe.creatorName)").font(.custom.ContentBold)
                Spacer()
                Text(recipe.createdAt).font(.custom.ContentItalic)
            }
            HStack(alignment: .center, spacing: 16) {
                VStack(spacing: 8) {
                    Image(systemName: "clock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.theme.Orange)
                        .frame(width: 24, height: 24)
                    Text("\(recipe.cookingTime) minutes").font(.custom.SubHeading).fontWeight(.regular)
                }.frame(maxWidth: .infinity)
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
                    Text("Serves \(recipe.servingSize)").font(.custom.SubHeading).fontWeight(.regular)
                }.frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.theme.White)
            .shadow(color: Color.theme.Black.opacity(0.3), radius: 0, x: 0, y: -1)
        }
        .padding(.top, 300)
        .padding(.horizontal, 25)
        .padding(.bottom, -300)
        .zIndex(100)
    }
    
}

private extension RecipeDetailView {
    func CoverImage(recipeDetail: Recipe) -> some View {
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
    }
}
