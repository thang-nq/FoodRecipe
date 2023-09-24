/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 10/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct FirebaseImage: View {
    @State var imagePathName: String
    @State private var avatarImage: UIImage?
    
    var body: some View {
        Group {
            if let avatarImage = avatarImage {
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Progress(loadingSize: 3)
            }
        }
        .onAppear {
            loadImageFromFirebase(pathName: imagePathName) { image in
                if let image = image {
                    self.avatarImage = image
                } else {
                    self.avatarImage = nil
                }
            }
        }
    }
    
}

//struct FirebaseImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseImageView()
//    }
//}
