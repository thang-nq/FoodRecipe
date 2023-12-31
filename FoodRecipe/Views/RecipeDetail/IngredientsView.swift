/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI


var MOCK_INGREDIENTS = ["3 green peppers, halved", "1/2 tsp hot smoked paprika", "3 garlic cloves, finely diced", "1 red onion, finely chopped", "corigander, leaves picked and roughly chopped, stems finely chopped"]
struct IngredientsView: View {
    var ingredientsList: [String]
    var body: some View {
        SectionContainerView {
            VStack (alignment: .leading) {
                ForEach(ingredientsList, id: \.self) { ingredient in
                    HStack {
                        Circle().fill(Color.theme.Orange).frame(width: 7, height: 7)
                        Text(ingredient).font(.custom.Content)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
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
