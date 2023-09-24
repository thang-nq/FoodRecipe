/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Man Pham
  ID: s3804811
  Created  date: 12/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI


var MOCK_INGREDIENTS = ["3 green peppers, halved", "1/2 tsp hot smoked paprika", "3 garlic cloves, finely diced", "1 red onion, finely chopped", "corigander, leaves picked and roughly chopped, stems finely chopped"]
struct IngredientsView: View {
    var ingredientsList: [String]
    var body: some View {
        SectionContainerView {
//            SectionTitleView(title: "Ingredients")
            VStack (alignment: .leading) {
                ForEach(ingredientsList, id: \.self) { ingredient in
                    HStack {
                        Circle().fill(Color.theme.Orange).frame(width: 7, height: 7)
                        Text(ingredient).font(.custom.Content)
                    }
                    
                }
            }
            
//            .frame(maxWidth: .infinity, alignment: .topLeading)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
//        .padding(.horizontal, 25)
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
