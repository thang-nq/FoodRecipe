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
    
    
    // MARK: Get a single recipe
    func getRecipeInformation(recipeID: String) async throws -> Recipe? {
        let document = try await db.document(recipeID).getDocument()
        let recipe = try document.data(as: Recipe.self)
        return recipe
    }
    
    // MARK: Get all recipe
    func getRecipeList() async throws -> [Recipe] {
        let snapshot = try await db.getDocuments()
        var recipes: [Recipe] = []
        for document in snapshot.documents {
            let recipe = try document.data(as: Recipe.self)
            recipes.append(recipe)
        }
        return recipes
    }
    
    // MARK: Get filtered recipe
    func getRecipeByFilters(filters: [String: Any]) async throws -> [Recipe] {
        let collectionRef = db
        var query = collectionRef as Query
        for (field, value) in filters {
            query = query.whereField(field, isEqualTo: value)
        }
        
        let snapshot = try await query.getDocuments()
        var recipes: [Recipe] = []
        for document in snapshot.documents {
            let recipe = try document.data(as: Recipe.self)
            recipes.append(recipe)
        }
        
        return recipes
    }
    
    
    // MARK: Get user created recipe
    func getUserCreatedRecipeList(userID: String) async throws -> [Recipe] {
        let snapshot = try await db.whereField("creatorID", isEqualTo: userID).getDocuments()
        var recipes: [Recipe] = []
        for document in snapshot.documents {
            let recipe = try document.data(as: Recipe.self)
            recipes.append(recipe)
        }
        print(recipes)
        return recipes
    }
    
    // MARK: Create new recipe with background from PhotosPicker
    func createNewRecipe(recipe: Recipe, backgroundImage: PhotosPickerItem?) async throws {
        let recipeID = db.document().documentID
        try db.document(recipeID).setData(from: recipe)
        // If provided an image and successfully update the background image, set the backgroundURL in recipe
        if backgroundImage != nil {
            try await uploadRecipeBGImage(data: backgroundImage!, recipeID: recipeID)
        }
        
    }
    
    
    // MARK: Upload recipe background image
    func uploadRecipeBGImage(data: PhotosPickerItem, recipeID: String) async throws {
        
        let resizedImageData = try await resizeImage(photoData: data, targetSize: CGSize(width: 450, height: 600))
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imageName = "\(recipeID)" + ".jpeg"
        let result = try await storage.child("recipeImage").child(imageName).putDataAsync(resizedImageData!, metadata: meta)
        guard let path = result.path else {
            throw RecipeManagerError.uploadImageFailed
        }
        try await db.document(recipeID).updateData(["backgroundURL": path])
    }
    
    // MARK: Delete recipe by ID
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

