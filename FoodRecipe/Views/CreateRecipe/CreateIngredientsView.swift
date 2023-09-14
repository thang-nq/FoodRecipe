//
//  CreateIngredientsView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI

struct CreateIngredientsView: View {
    @State private var showingSheet = false
    @State private var InputIngredient = ""
    @State private var Ingredients: [String] = []
    var body: some View {
        VStack(alignment: .leading) {
            if(Ingredients.isEmpty){
                HStack {
                            Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                            Text("Click the plus button below to add ingredient")
                                .font(.custom("ZillaSlab-Regular", size: 20))
                }.padding(.leading, 20)
            }
            ForEach(Ingredients, id: \.self) { igredient in
                HStack {
                            Text("•")
                                .font(.title)
                            Text(igredient)
                                .font(.custom("ZillaSlab-Regular", size: 20))
                }
                .padding(.leading, 20)
            }
            Spacer()
            
            HStack(){
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
            BottomSheetView(InputIngredient: $InputIngredient, Ingredients: $Ingredients)
                .presentationDetents([.height(300)])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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

struct BottomSheetView: View {
    @Binding var InputIngredient : String
    @Binding var Ingredients : [String]
    var body: some View{
        VStack{
            InputFieldRecipe(text: $InputIngredient, title: "Ingredient", placeHolder: "Enter Ingredient") }
            Button(action: {
                if(!InputIngredient.isEmpty){
                    Ingredients.append(InputIngredient)
                    InputIngredient = ""
                }
            }) {
                Text("Save")
                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(width: 120, height: 40)
                                    .background(Color("Orange"))
                                    .cornerRadius(8)

            }
        }
}

struct CreateIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIngredientsView()
    }
}
