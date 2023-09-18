//
//  CreateIngredientsView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI

struct CreateIngredientsView: View {
    // MARK: VARIABLES
    @State private var showingSheet = false
    @State private var InputIngredient = ""
    @Binding var Ingredients: [String]
    
    // MARK: FUNCTION
    // Remove Ingredient function
    private func removeIngredient(_ ingredient: String) {
        if let index = Ingredients.firstIndex(of: ingredient) {
            Ingredients.remove(at: index)
        }
    }
    
    var body: some View {
        // MARK: MAIN LAYOUT
        VStack{
            ScrollView{
                    ingredients
                        .accessibilityLabel("Ingredients")
            }
        }
        .sheet(isPresented: $showingSheet){
            AddIngredientsSheetView(InputIngredient: $InputIngredient, Ingredients: $Ingredients)
                .presentationDetents([.height(300)])
        }
        .frame(maxWidth: 500, maxHeight: .infinity, alignment: .topLeading)
        .overlay(
            // Create new ingredient button
            Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color("Orange"))
                                .clipShape(Circle())
                                
            })
            .modifier(ButtonModifier()),
            alignment: .bottomTrailing
        )
        
    }
}

// Button modifier
struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .padding(.bottom, 20)
          .padding(.trailing, 10)
      
  }
}

// MARK: ADD INGREDIENTS SHEET VIEW
struct AddIngredientsSheetView: View {
    @Binding var InputIngredient : String
    @Binding var Ingredients : [String]
    var body: some View{
        VStack{
            InputFieldRecipe(text: $InputIngredient, title: "Ingredient", placeHolder: "Enter Ingredient")
        }
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
        CreateIngredientsView(Ingredients: .constant([]))
    }
}

private extension CreateIngredientsView{
    // MARK: INGREDIENTS UI
    var ingredients: some View{
        VStack(alignment: .leading) {
            if(Ingredients.isEmpty){
                HStack {
                    Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                    Text("Click the plus button below to adding ingredient")
                        .font(.custom("ZillaSlab-Regular", size: 20))
                        
                }.padding(.leading, 20)
            }
            ForEach(Ingredients, id: \.self) { ingredient in
                HStack() {
                    Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                    Text(ingredient)
                        .font(.custom("ZillaSlab-Regular", size: 20))
                        .frame(width: 280, alignment: .leading)
                    Spacer()
                    Button(action: {
                        removeIngredient(ingredient)
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("Orange"))
                            .padding(.trailing, 15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            }
            Spacer()
        }
    }
}
