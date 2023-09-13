//
//  RecipeDetailView.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI
import SlidingTabView

struct RecipeDetailView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .top) {
                    Color("LightGray")
                    // MARK: Overlay Image
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: .infinity, height: 408)
                        .background(
                            Image("soup")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 408)
                                .clipped()
                        )
                        .offset(y: -60)
                    
                    TopBar
                    VStack(spacing: 15) {
                        ZStack {
                            VStack(spacing: 15) {
                                MainInfo
                                NutritionView()
                            }
                        }
                        VStack {
                            
                            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
                            
                            if selectedTabIndex == 0 {
                                //                                IngredientsView(ingredientsList: MOCK_INGREDIENTS)
//                                HStack {
//                                    Text("A small paragraph some info about recipe. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
//                                        .font(.custom("ZillaSlab-Regular", size: 20))
//                                        .frame(maxWidth: .infinity, alignment: .topLeading)
//
//                                }
                                SectionContainerView {
                                    Text("A small paragraph some info about recipe. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vestibulum mi eu augue tristique maximus. Nam dictum scelerisque laoreet. Sed vel imperdiet metus, eget congue nibh. Aliquam tempus turpis mattis lorem pharetra, in gravida diam ultrices.\nPraesent felis lorem, aliquet vel dui non, congue pellentesque metus. In malesuada, nisl ut venenatis accumsan, sapien odio tincidunt sem, vel bibendum erat ex et neque.")
                                        .font(.custom("ZillaSlab-Regular", size: 20))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                                }
                            }
                            
                            if selectedTabIndex == 1 {
                                IngredientsView(ingredientsList: MOCK_INGREDIENTS)
                            }
                            
                            if selectedTabIndex == 2 {
                                StepsView(stepsList: MOCK_STEPS)
                            }
                            
                        }.background(Color.theme.White)
                        //                        IngredientsView(ingredientsList: MOCK_INGREDIENTS)
                        //                        StepsView(stepsList: MOCK_STEPS)
                    }
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}

// MARK: Top Bar
var TopBar: some View {
    HStack  {
        Image("chevron-left")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.white)
            .padding(10)
            .background(.white)
            .clipShape(Circle())
        
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


// MARK: Main Info
var MainInfo: some View {
    SectionContainerView {
        Text("Chicken Soup Oven Potato")
            .font(.custom("ZillaSlab-BoldItalic", size: 26)).fontWeight(.medium)
            .kerning(0.552)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        HStack{
            Tag(text: "Healthy")
            Tag(text: "Vegan")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            Text("By ") + Text("**Nick Tran**").font(.custom("ZillaSlab-BoldItalic", size: 20)).fontWeight(.medium)
            Spacer()
            Text("September 1st, 2023")
        }
        Divider()
        Text("A small paragraph some info about recipe. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
            .font(.custom("ZillaSlab-Regular", size: 20))
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    .padding(.top, 300)
    .padding(.horizontal, 25)
    .padding(.bottom, -300)
    .zIndex(100)
}

