/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tien Tran
  ID: s3919657
  Created  date: 19/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct UpdateIngredientsView: View {
    @AppStorage("isDarkMode") var isDark = false
    // MARK: VARIABLES
    @State private var showingSheet = false
    @State private var showingUpdateSheet = false
    @State private var InputIngredient = ""
    @State private var updateInputIngredient = ""
    @Binding var Ingredients: [String]
    
    // MARK: FUNCTION
    // Remove Ingredient function
    private func removeIngredient(_ ingredient: String) {
        if let index = Ingredients.firstIndex(of: ingredient) {
            Ingredients.remove(at: index)
        }
    }
    
    private func updateIngredient(_ ingredient: String) {
        updateInputIngredient = ingredient
        showingUpdateSheet.toggle()
    }
    
    var body: some View {
        // MARK: MAIN LAYOUT
        VStack{
            ScrollView{
                    ingredients
                        .accessibilityLabel("Ingredients")
            }
        }
        .overlay(
            // MARK: ADD INGREDIENTS BUTTON
            Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(Color.theme.WhiteInstance)
                                .padding(20)
                                .background(Color.theme.OrangeInstance)
                                .clipShape(Circle())
                                
            })
            .modifier(ButtonModifier()),
            alignment: .bottomTrailing
        )
        .sheet(isPresented: $showingSheet){
            // MARK: ADD INGREDIENTS SHEET
            AddIngredientsSheetView(InputIngredient: $InputIngredient, Ingredients: $Ingredients)
                .presentationDetents([.height(150)])
                .presentationBackground(isDark ? Color.theme.DarkGray : Color.theme.White)
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
        .sheet(isPresented: $showingUpdateSheet){
            // MARK: UPDATE INGREDIENTS SHEET
            UpdateIngredientsSheetView(updateInputIngredient: $updateInputIngredient, Ingredients: $Ingredients, showingUpdateSheet: $showingUpdateSheet)
                .presentationDetents([.height(150)])
                .presentationBackground(isDark ? Color.theme.DarkGray : Color.theme.White)
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
        
    }
}


struct UpdateIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateIngredientsView(Ingredients: .constant([]))
    }
}

private extension UpdateIngredientsView{
    // MARK: INGREDIENTS UI
    var ingredients: some View{
        VStack(alignment: .leading) {
            if(Ingredients.isEmpty){
                HStack {
                    Circle().fill(Color.theme.OrangeInstance).frame(width: 10, height: 10)
                    Text("Click the plus button below to adding ingredient")
                        .font(Font.custom.Content)
                        
                }.padding(.leading, 20)
            }
            ForEach(Ingredients, id: \.self) { ingredient in
                HStack() {
                    Circle().fill(Color.theme.OrangeInstance).frame(width: 10, height: 10)
                    Text(ingredient)
                        .font(Font.custom.Content)
                        .frame(width: 260, alignment: .leading)
                    Button(action: {
                        updateIngredient(ingredient)
                    }) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 15)
                    }
                    Button(action: {
                        removeIngredient(ingredient)
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            }
            Text("")
                .frame(height: 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

