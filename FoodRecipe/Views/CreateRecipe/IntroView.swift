//
//  IntroView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI

struct IntroView: View {
    @State private var recipeName = ""
    @State private var minute = ""

    var body: some View {
                VStack{
                    HStack{
                        Text("Title:")
                                .font(.custom("ZillaSlab-SemiBold", size: 26))
                                .padding(.leading, 20)
                        Spacer()
                    }
        
                    TextField(("Enter recipe name"), text: $recipeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("ZillaSlab-Regular", size: 18))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    HStack{
                        Text("Cook time:")
                                .font(.custom("ZillaSlab-SemiBold", size: 26))
                                .padding(.leading, 20)
                        Spacer()
                    }.padding(.bottom, 10)
                    HStack{
                        VStack{
                            Text("Minutes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Enter Minutes", text: $minute)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.trailing, 20)
                        }
                        Spacer()
                        VStack{
                            Text("Minutes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Enter Minutes", text: $minute)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.trailing, 20)
                        }
                        
                    } .padding(.horizontal, 20)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
