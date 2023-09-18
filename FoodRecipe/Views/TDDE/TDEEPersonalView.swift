//
//  TDEEPersonalView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 18/09/2023.
//

import SwiftUI

struct TDEEPersonalView: View {
    
    @State var TDEENumber: Int = 0
    @State var caloriesConsumed: Int = 0
    
    //MARK: init font cus nav title
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                caloriesCalculate
            }
            .navigationTitle("Today's calories")
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
        HStack {
            Text("Total calories: \(TDEENumber)")
            Text("Calories balancse: \(caloriesConsumed)")
            Text("Balance calories: \(TDEENumber - caloriesConsumed)")
        }
    }
    
//    //MARK: TODAY'S FOOD LIST
//    var todayList: some View {
//        List {
//
//        }
//    }
}
