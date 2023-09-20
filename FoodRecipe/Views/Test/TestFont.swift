//
//  TestFont.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 20/09/2023.
//

import SwiftUI

struct TestFont: View {
    var body: some View {
        
        VStack(spacing: 10) {

            Text("Navigation Title")
                .font(Font.custom.NavigationTitle)
            
            Text("Navigation Title Italic")
                .font(Font.custom.NavigationTitleItalic)
            
            Text("Heading")
                .font(Font.custom.Heading)
            
            Text("Heading Italic")
                .font(Font.custom.HeadingItalic)
            
            Text("SubHeading")
                .font(Font.custom.SubHeading)
            
            Text("SubHeading Italic")
                .font(Font.custom.SubHeadingItalic)
            
            VStack(spacing: 10) {
                
                Text("Content regular")
                    .font(Font.custom.Content)
                
                Text("Content italic")
                    .font(Font.custom.ContentItalic)
                
                Text("Sub content regular")
                    .font(Font.custom.SubContent)
                
                Text("Sub content italic")
                    .font(Font.custom.SubContentItalic)
                
            }

            VStack(spacing: 10) {
                
                //MARK: COMPONENT
                Button(action:{}){
                    Text("Submit")
                        .font(Font.custom.ButtonText)
                        .frame(width: 150, height: 50)
                        .contentShape(Rectangle())
                }
                .foregroundColor(Color.theme.DarkBlueInstance)
                .background(Color.theme.Orange)
                .cornerRadius(8)
            }

        }
            
 
    }
}

struct TestFont_Previews: PreviewProvider {
    static var previews: some View {
        TestFont()
    }
}
