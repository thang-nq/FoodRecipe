//
//  UserManager.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 13/09/2023.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import PhotosUI




final class RecipeManager {
    static let shared = RecipeManager()
    private var db = Firestore.firestore().collection("recipes")
    private var storage = Storage.storage().reference()
    private init() {
    }
    

    func getRecipeInformation(recipeID: String) async throws -> Recipe? {
        let document = try await db.document(recipeID).getDocument()
        let recipe = try document.data(as: Recipe.self)
        return recipe
    }
    
    
    
    func getRecipeList() async throws -> [Recipe] {
        let snapshot = try await db.getDocuments()
        var recipes: [Recipe] = []
        for document in snapshot.documents {
            let recipe = try document.data(as: Recipe.self)
            recipes.append(recipe)
        }
        return recipes
    }
    
//    func getMyRecipeList(userID: String) async throws -> [Recipe] {
//        let snapshot = try await db.getDocuments()
//        var recipes: [Recipe] = []
//        return recipes
//    }
    
    func createNewRecipe(recipe: Recipe, backgroundImage: PhotosPickerItem?) async throws {
        let recipeID = db.document().documentID
        try db.document(recipeID).setData(from: recipe)
        // If provided an image and successfully update the background image, set the backgroundURL in recipe
        if backgroundImage != nil {
            if let backgroundImageURL = try? await uploadRecipeBGImage(data: backgroundImage!, recipeID: recipeID) {
                try await db.document(recipeID).updateData(["backgroundURL": backgroundImageURL])
            }
        }
        
    }
    
    
    func uploadRecipeBGImage(data: PhotosPickerItem, recipeID: String) async throws -> String {
        
        let resizedImageData = try await resizeImage(photoData: data, targetSize: CGSize(width: 450, height: 600))
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imageName = "\(recipeID)" + ".jpeg"
        let result = try await storage.child("recipeImage").child(imageName).putDataAsync(resizedImageData!, metadata: meta)
        guard let path = result.path else {
            throw RecipeManagerError.uploadImageFailed
        }
        return path
    }
    
    
    func deleteRecipe(recipeID: String) async throws {
        do {
            if let recipe = try await self.getRecipeInformation(recipeID: recipeID) {
                
                try await db.document(recipeID).delete()
                // Delete background image
                if !recipe.backgroundURL.isEmpty {
                    try await storage.child(recipe.backgroundURL).delete()
                }
            }
            
        } catch {
            print("DEBUG - \(error.localizedDescription)")
        }
    }
}

