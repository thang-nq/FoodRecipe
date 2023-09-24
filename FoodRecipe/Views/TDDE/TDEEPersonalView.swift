/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI

struct TDEEPersonalView: View {
    
    // State variable to navigate to TDEE form
    @State private var navigateToTDEEForm = false
    
    // Environment object for authentication
    @EnvironmentObject private var authVM: AuthViewModel
    
    // Shared TDDE view model
    @StateObject private var tddeViewModel = TDDEViewModel.shared
    
    // App storage for TDDE intro
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = true

    //MARK: MAIN LAYOUT
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


//MARK: UI VARS
private extension TDEEPersonalView {
    
    //MARK: TITLE
    var title: some View {
        Text("Daily Energy Expenditure")
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
            RoundedCorners(color: Color.theme.DarkGray.opacity(0.1), tl: 10, tr: 10, bl: 10, br: 10)
                .shadow(color: Color.theme.LightGray.opacity(0.1) ,radius: 2)
        )
    }
    
    //MARK: TODAY'S FOOD LIST
    var todayList: some View {
        VStack(alignment: .leading){
            Text("Today Meals")
                .font(Font.custom.Heading)
                .padding(.horizontal, 20)
            ScrollView {
                ForEach(tddeViewModel.tddeRecipes) {recipe in
                    RecipeCard(id: recipe.id!, calories: recipe.calories, name: recipe.name, imageURL: recipe.backgroundURL, protein: recipe.protein, fat: recipe.fat, carb: recipe.carb) // display recipe card component with list data
                }
                
            }
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
        .font(Font.custom.Heading)
        .foregroundColor(Color.theme.OrangeInstance)

    }
    
}
