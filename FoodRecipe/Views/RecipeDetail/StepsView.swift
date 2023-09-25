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

struct StepsView: View {
    var stepsList: [CookingStep]
    var body: some View {
        SectionContainerView {
            VStack (alignment: .leading) {
                ForEach(stepsList) { step in
                    HStack {
                        Circle().fill(Color.theme.Orange).frame(width: 7, height: 7)
                        Text(step.context).font(.custom.Content)
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
            StepsView(stepsList: Recipe.sampleRecipe.steps)
        }
    }
}
