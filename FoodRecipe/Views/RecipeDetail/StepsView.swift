//
//  StepsView.swift
//  FoodRecipe
//
//  Created by Man Pham on 12/09/2023.
//

import SwiftUI

//var MOCK_STEPS = ["Setelah dicuci bersih, rebus sayap ayam hingga matang dengan 500 ml air. Buang busanya dan saring untuk dijadikan kaldu. ",
//                  "Tumis bawang putih, bawang merah dan daun bawang hingga harum. Masukkan pala dan lada bubuk, tumis sebentar. Matikan api. ",
//                  "3 garlic cloves, finely diced",
//                  "Rebus lagi air kaldu, masukkan makaroni dan masak hingga setengah matang. Masukkan wortel dan masak hingga mendidih. ",
//                  "Masukkan bumbu dan daun seledri. Masak hingga semua bahan matang dan kuah sedap."]
var MOCK_STEPS = [CookingStep(context: "Do this and that", backgroundURL: "", stepNumber: 1)]
struct StepsView: View {
    var stepsList: [CookingStep]
    var body: some View {
        SectionContainerView {
//            SectionTitleView(title: "Steps")
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Enter Cook Mode").foregroundColor(Color.theme.Orange)
                }

            }
            VStack (alignment: .leading) {
                ForEach(stepsList) { step in
                    HStack {
                        Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                        Text(step.context)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            Color("LightGray").ignoresSafeArea(.all)
            StepsView(stepsList: MOCK_STEPS)
        }
    }
}
