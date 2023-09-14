//
//  TestColors.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 13/09/2023.
//

import SwiftUI

struct TestColors: View {
    var body: some View {
        
        VStack(spacing: 10) {
            Text("ACCENT COLORS")
                .font(.custom("ZillaSlab-BoldItalic", size: 30))
            
            VStack(spacing: 10) {
                Text("White")
                    .foregroundColor(Color.theme.White)
            
                Text("Black")
                    .foregroundColor(Color.theme.Black)
                
                Text("Blue")
                    .foregroundColor(Color.theme.Blue)
                
                Text("DrakBlue")
                    .foregroundColor(Color.theme.DarkBlue)
                
                Text("DarkGray")
                    .foregroundColor(Color.theme.DarkGray)
                
                Text("DrarkWhite")
                    .foregroundColor(Color.theme.DarkWhite)
            }
            
            VStack(spacing: 10){
                Text("Gray")
                    .foregroundColor(Color.theme.Gray)
                
                Text("LightBlue")
                    .foregroundColor(Color.theme.LightBlue)
                
                Text("LightGray")
                    .foregroundColor(Color.theme.LightGray)
                
                Text("LightOrange")
                    .foregroundColor(Color.theme.LightOrange)

                Text("Orange")
                    .foregroundColor(Color.theme.Orange)

            }
            
            Text("INSTANCE COLORS")
                .font(.custom("ZillaSlab-BoldItalic", size: 30))
            
            VStack(spacing: 10){

                Text("WhiteInstance")
                    .foregroundColor(Color.theme.WhiteInstance)
            
                Text("BlackInstance")
                    .foregroundColor(Color.theme.BlackInstance)
                
                Text("BlueInstance")
                    .foregroundColor(Color.theme.BlueInstance)
                
                Text("DrakBlueInstance")
                    .foregroundColor(Color.theme.DarkBlueInstance)
                
                Text("DarkGrayInstance")
                    .foregroundColor(Color.theme.DarkGrayInstance)
                
                Text("DrarkWhiteInstance")
                    .foregroundColor(Color.theme.DarkWhiteInstance)
            }
            
            VStack(spacing: 10){
                Text("GrayInstance")
                    .foregroundColor(Color.theme.GrayInstance)
                
                Text("LightBlueInstance")
                    .foregroundColor(Color.theme.LightBlueInstance)
                
                Text("LightGrayInstance")
                    .foregroundColor(Color.theme.LightGrayInstance)
                
                Text("LightOrangeInstance")
                    .foregroundColor(Color.theme.LightOrangeInstance)

                Text("OrangeInstance")
                    .foregroundColor(Color.theme.OrangeInstance)
                
                Text("RedInstance")
                    .foregroundColor(Color.theme.RedInstance)
                
                Text("GreenInstance")
                    .foregroundColor(Color.theme.GreenInstance)
            }

        }

    }
}

struct TestColors_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {

            TestColors()
                .previewDisplayName("iOS light")
                .preferredColorScheme(.light)
            
            TestColors()
                .previewDisplayName("iOS dark")
                .preferredColorScheme(.dark)
            
        }
    }
}


