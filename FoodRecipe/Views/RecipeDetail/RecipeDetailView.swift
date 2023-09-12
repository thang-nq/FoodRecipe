//
//  RecipeDetailView.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .top) {
                    Color("LightGray").ignoresSafeArea(.all)
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
                    VStack {
                        MainInfo
                        NutritionView()
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
}

