//
//  CreateIngredientsView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI

struct CreateIngredientsView: View {
    @State private var showingSheet = false
    var body: some View {
        
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
            
            HStack{
                Spacer()
                Button(action: {
                                showingSheet.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .padding(20)
                                    .background(Color("Orange"))
                                    .clipShape(Circle())
                            }
            }
            .padding(.trailing, 15)
            .padding(.bottom, 70)
            
          
            
        }
        .sheet(isPresented: $showingSheet){
            Text("helo")
        }
//        .overlay(
//            Button(action: {
//                showingSheet.toggle()
//            }, label: {
//                Image(systemName: "plus")
//                                .font(.system(size: 24))
//                                .foregroundColor(.white)
//                                .padding(20)
//                                .background(Color("Orange"))
//                                .clipShape(Circle())
//                                .offset(x:150, y:270)
//            })
//        )
        
    }
}



struct CreateIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIngredientsView()
    }
}
