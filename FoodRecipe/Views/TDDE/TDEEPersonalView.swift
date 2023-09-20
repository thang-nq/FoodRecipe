//
//  TDEEPersonalView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 18/09/2023.
//

import SwiftUI

struct TDEEPersonalView: View {
    
    @State var TDEENumber: Int = 3000
    @State var caloriesConsumed: Int = 2456
    @State private var navigateToTDEEForm = false
    
    //MARK: init font cus nav title
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    caloriesCalculate
                        .frame(height: 200)
                    
                    todayList
                        .padding(.top, 20)
                }
                .navigationTitle("MY CALORIES")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: reCalButton)
                
            }
        }
    }
}

struct TDEEPersonalView_Previews: PreviewProvider {
    static var previews: some View {
        TDEEPersonalView()
    }
}


private extension TDEEPersonalView {
    
    //MARK: CALCULATOR PERSONAL UI
    var caloriesCalculate: some View {
        VStack(alignment: .center){
            Text("Personal TDEE")
                .foregroundColor(Color.theme.DarkBlue)
                .font(Font.custom.Heading)
                .padding(.bottom, 5)
            
            HStack{
                Text("Carbs: 90g")
                Divider()
                Text("Protein: 120g")
                Divider()
                Text("Fat: 40g")
            }
            .foregroundColor(Color.theme.Blue)
            .font(Font.custom.ContentRegular)
            
            Divider()
                .frame(width: 350, height: 2)
                .background(Color.theme.DarkBlue)
                
            
            HStack(alignment: .center, spacing: 40){
                
                VStack{
                    Text("Total Calo")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(TDEENumber)")
                }
                            
                VStack{
                    Text("Consumed")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(caloriesConsumed)")
                }
                
        
                VStack {
                    Text("Balance")
                        .foregroundColor(Color.theme.Orange)
                    Text("\(TDEENumber - caloriesConsumed)")
                }
    
            }
            .frame(height: 80)
            .font(Font.custom.SubHeading)
        }
        .padding()
        .background(
            RoundedCorners(color: Color.theme.WhiteInstance, tl: 5, tr: 5, bl:5, br: 5)
                .shadow(color: Color.theme.DarkBlueInstance.opacity(0.5) ,radius: 2)
        )
    }
    
    //MARK: TODAY'S FOOD LIST
    var todayList: some View {
        VStack(alignment: .leading){
            Text("Today Meals")
                .font(.custom("ZillaSlab-Bold", size: 26))
                .padding(.horizontal, 20)
            ScrollView {
                RecipeCard()
                Divider()
                RecipeCard()
                Divider()
                RecipeCard()
                Divider()
                RecipeCard()
            }
            .padding(.horizontal)
        }
    }
    
    //MARK: RECAlCULATE TDEE
    var reCalButton: some View {
        Button(action: {
            navigateToTDEEForm = true
        }){
            Text("Recalculator")
        }
        .navigationDestination(isPresented: $navigateToTDEEForm){
            TDDEFormView()
        }
        .font(Font.custom.ButtonText)
        .frame(width: 150, height: 40, alignment: .center)
        .foregroundColor(Color.theme.DarkBlue)
        .background(Color.theme.OrangeInstance)
        .cornerRadius(8)

    }
    
}
