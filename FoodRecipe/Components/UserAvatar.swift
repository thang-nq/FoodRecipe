//
//  UserAvatar.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import FirebaseStorage

struct UserAvatar: View {
    @Binding var imagePathName: String // userID
    @State private var avatarImage: UIImage?
    
    var body: some View {
        Group {
            if let avatarImage = avatarImage {
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 200)
                
            } else {
                Text("Loading")
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

//struct UserAvatar_Previews: PreviewProvider {
//    static var previews: some View {
//        UserAvatar(imagePath: "bTkv0B2aBnYYjDoyayGItpTOLi82.jpeg")
//    }
//}
