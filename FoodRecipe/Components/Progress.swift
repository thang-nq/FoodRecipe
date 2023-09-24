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

struct Progress: View {
    var loadingSize: CGFloat // Size for scaling the progress view
    
    var body: some View {
        
            ProgressView() // Display a progress view
            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.OrangeInstance)) // Apply circular progress view style with an orange tint
            .scaleEffect(loadingSize > 0 ? loadingSize : 3) // Scale the progress view based on the loadingSize parameter (default to 3 if loadingSize <= 0)
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        Progress(loadingSize: 3) // Preview the Progress view with a loading size of 3
    }
}
