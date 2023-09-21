//
//  TDEEPersonalView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 18/09/2023.
//

import SwiftUI

struct TDEEPersonalView: View {
    
    @State private var navigateToTDEEForm = false
    @EnvironmentObject private var authVM: AuthViewModel
    @StateObject private var tddeViewModel = TDDEViewModel.shared
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = true
    
//    //MARK: init font cus nav title
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
//    }

    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    title
                    caloriesCalculate
                        .frame(height: 200)
                        .overlay(alignment: .topTrailing) {
                            reCalButton
                                .padding(.vertical, 5)
                        }
                    
                    todayList
                        .padding(.top, 20)
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            }
        }
        .fullScreenCover(isPresented: $TDDEIntro, content: {
            TDEEWelcomeList()
        })
    }
}


private extension TDEEPersonalView {
    
    //MARK: TITLE
    var title: some View {
        Text("Total Daily Energy Expenditure")
            .font(Font.custom.NavigationTitle)
    }
    
    //MARK: CALCULATOR PERSONAL UI
    var caloriesCalculate: some View {
        VStack(alignment: .center){
                        
            Text("Personal TDEE")
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.Heading)
                .padding(.bottom, 5)
            
            HStack{
                Text("Carbs: \(tddeViewModel.recommendCarb)g")
                Divider()
                Text("Protein: \(tddeViewModel.recommendProtein)g")
                Divider()
                Text("Fat: \(tddeViewModel.recommendFat)g")
            }
            .foregroundColor(Color.theme.Blue)
            .font(Font.custom.Content)
            
            Divider()
                .frame(width: 350, height: 2)
                .background(Color.theme.DarkBlue)
                

            HStack(alignment: .center, spacing: 40){
                
                VStack{
                    Text("Total Calo")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(tddeViewModel.recommendCal)")
                }
                            
                VStack{
                    Text("Consumed")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(tddeViewModel.consumedCal)")
                }
                
                VStack {
                    Text("Balance")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(tddeViewModel.recommendCal - tddeViewModel.consumedCal)")
                }
    
            }
            .frame(height: 80)
            .font(Font.custom.SubHeading)
        }
        .padding()
        .background(
            RoundedCorners(color: Color.theme.White, tl: 5, tr: 5, bl:5, br: 5)
                .shadow(color: Color.theme.DarkBlueInstance.opacity(0.8) ,radius: 5)
        )
    }
    
    //MARK: TODAY'S FOOD LIST
    var todayList: some View {
        VStack(alignment: .leading){
            Text("Today Meals")
                .font(.custom("ZillaSlab-Bold", size: 26))
                .padding(.horizontal, 20)
            ScrollView {
                ForEach(tddeViewModel.tddeRecipes) {recipe in
                    RecipeCard(id: recipe.id!, calories: recipe.calories, name: recipe.name, imageURL: recipe.backgroundURL, protein: recipe.protein, fat: recipe.fat, carb: recipe.carb)
                }
                
            }
            .padding(.horizontal)
        }
    }
    
    //MARK: RECAlCULATE TDEE
    var reCalButton: some View {
        Button(action: {
            navigateToTDEEForm = true
        }){
            Label("", systemImage: "pencil.line")
        }
        .navigationDestination(isPresented: $navigateToTDEEForm){
            TDDEFormView()
        }
        .font(Font.custom.ContentBold)
        .foregroundColor(Color.theme.OrangeInstance)

    }
    
}
