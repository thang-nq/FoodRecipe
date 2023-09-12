//
//  IngredientsView.swift
//  FoodRecipe
//
//  Created by Man Pham on 12/09/2023.
//

import SwiftUI


var MOCK_INGREDIENTS = ["3 green peppers, halved", "1/2 tsp hot smoked paprika", "3 garlic cloves, finely diced", "1 red onion, finely chopped", "corigander, leaves picked and roughly chopped, stems finely chopped"]
struct IngredientsView: View {
    var ingredientsList: [String]
    var body: some View {
        SectionContainerView {
            SectionTitleView(title: "Ingredients")
            VStack (alignment: .leading) {
                ForEach(ingredientsList, id: \.self) { ingredient in
                    HStack {
                        Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                        Text(ingredient)
                    }
                    
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.horizontal, 25)
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            Color("LightGray").ignoresSafeArea(.all)
            IngredientsView(ingredientsList: MOCK_INGREDIENTS)
        }
    }
}
