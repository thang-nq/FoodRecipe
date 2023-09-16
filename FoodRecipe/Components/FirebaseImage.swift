//
//  FirebaseImageView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//

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
