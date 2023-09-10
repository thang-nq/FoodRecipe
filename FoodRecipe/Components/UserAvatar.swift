//
//  UserAvatar.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import FirebaseStorage

struct UserAvatar: View {
    @State private var image: UIImage?
    @State var imagePath: String
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .onAppear(perform: loadImageFromFirebase)
                .clipShape(Circle())
        } else {
            Text("Loading...")
                .onAppear(perform: loadImageFromFirebase)
        }
            
    }
    
    func loadImageFromFirebase() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageRef = storageRef.child(imagePath)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image \(error.localizedDescription)")
            } else if let data = data {
                if let loadedImage = UIImage(data: data) {
                    self.image = loadedImage
                } else {
                    print("Failed to created image from data")
                }
            }
        }
    }
}

struct UserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatar(imagePath: "bTkv0B2aBnYYjDoyayGItpTOLi82.jpeg")
    }
}
