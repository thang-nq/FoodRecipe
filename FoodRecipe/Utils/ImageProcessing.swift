//
//  ImageProcessing.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import PhotosUI


func resizeImage(photoData: PhotosPickerItem, targetSize: CGSize) async throws -> Data? {
    let imageData = try await photoData.loadTransferable(type: Data.self)
    if imageData != nil {
        let image = UIImage(data: imageData!)
        
        let size = image!.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image!.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let data = newImage?.jpegData(compressionQuality: 0.5)
        
        return data
    }
    return nil
    
}
