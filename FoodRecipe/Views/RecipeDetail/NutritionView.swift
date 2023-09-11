//
//  NutritionView.swift
//  FoodRecipe
//
//  Created by Man Pham on 11/09/2023.
//

import SwiftUI

struct NutritionView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 16) {
                Text("Nutrition")
                    .font(.custom("ZillaSlab-BoldItalic", size: 26)).fontWeight(.medium)
                    .kerning(0.552)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
          
                NutritionList
                
            }
            .padding(16)
            .frame(width: .infinity, alignment: .top)
            .background(.white)
            .cornerRadius(16)
        }
        .padding(.top, 300)
        .padding(.horizontal, 25)    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            Color("LightGray").ignoresSafeArea(.all)
            NutritionView()
        }
    }
}

// MARK: Nutrition List
var NutritionList: some View {
    HStack {
        VStack (spacing: 7){
            Text("kcal")
                .font(.system(size: 18))
                .foregroundColor(Color.theme.White)
                .bold()
            Text("256")
                .font(.system(size: 22))
                .foregroundColor(Color.theme.White)
                .fontWeight(.semibold)
        }
        .padding(10)
        .frame(width: 100, height: 80)
        .background(Color.theme.LightOrange)
        .cornerRadius(10)
        
        VStack (spacing: 7){
            Text("carbs")
                .font(.system(size: 18))
                .foregroundColor(Color.theme.White)
                .bold()
            Text("256")
                .font(.system(size: 22))
                .foregroundColor(Color.theme.White)
                .fontWeight(.semibold)
        }
        .padding(10)
        .frame(width: 100, height: 80)
        .background(Color.theme.LightOrange)
        .cornerRadius(10)
        
        
        VStack (spacing: 7){
            Text("fibre")
                .font(.system(size: 18))
                .foregroundColor(Color.theme.White)
                .bold()
            Text("16g")
                .font(.system(size: 22))
                .foregroundColor(Color.theme.White)
                .fontWeight(.semibold)
        }
        .padding(10)
        .frame(width: 100, height: 80)
        .background(Color.theme.LightOrange)
        .cornerRadius(10)
    }
}
