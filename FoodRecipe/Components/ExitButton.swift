/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tuan Le
  ID: s3836290
  Created  date: 21/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

// navigation button use in header
// A custom back button, providing a visual indicator and a tap gesture for the user to go back to the previous view
struct ExitButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        // Custom back button shape and back button behavior dismiss
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .foregroundColor(Color.theme.OrangeInstance)
                .imageScale(.large)
        }
    }
}

struct ExitButton_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton()
    }
}
