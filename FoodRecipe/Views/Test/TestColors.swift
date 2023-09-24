/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tuan Le
  ID: s3836290
  Created  date: 13/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct TestColors: View {
    var body: some View {
    
        VStack(spacing: 10) {
            Text("ACCENT COLORS")
                .font(.custom("ZillaSlab-BoldItalic", size: 20))
            
            VStack(spacing: 10) {
            
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
                .font(.custom("ZillaSlab-BoldItalic", size: 20))
            
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
                
                Text("YellowInstance")
                    .foregroundColor(Color.theme.YellowInstance)
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




