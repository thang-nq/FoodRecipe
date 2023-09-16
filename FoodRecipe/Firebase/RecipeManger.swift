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
    
    
    // MARK: Get a single recipe with all cooking steps
    func getRecipeInformation(recipeID: String) async -> Recipe? {
        var recipe : Recipe? = nil
        do {
            let document = try await db.document(recipeID).getDocument()
            recipe = try document.data(as: Recipe.self)
            let stepsData = try await db.document(recipeID).collection("cookingSteps").getDocuments()
            var steps: [CookingStep] = []
            for d in stepsData.documents {
                let step = try d.data(as: CookingStep.self)
                steps.append(step)
            }
            
            // Fetch creator data
            if let user = await UserManager.shared.getUserData(userID: recipe!.creatorID) {
                recipe!.creatorName = user.fullName
                recipe!.creatorAvatar = user.avatarUrl
            }
            
            // Format time
            recipe!.createdAt = formatTimestamp(recipe!.timeStamp)
            
            // Sort the step
            let sortedSteps = steps.sorted { $0.stepNumber < $1.stepNumber}
            recipe!.steps = sortedSteps
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }

        return recipe
    }
    
    // MARK: Get all recipe
    func getRecipeList() async -> [Recipe] {
        var recipes: [Recipe] = []
        do {
            let snapshot = try await db.getDocuments()
            
            for document in snapshot.documents {
                var recipe = try document.data(as: Recipe.self)
                // Fetch user
                if let user = await UserManager.shared.getUserData(userID: recipe.creatorID) {
                    recipe.creatorName = user.fullName
                    recipe.creatorAvatar = user.avatarUrl
                }
                // format time stamp
                recipe.createdAt = formatTimestamp(recipe.timeStamp)
                recipes.append(recipe)
                
            }
            
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        return recipes
    }
    
    // MARK: Get filtered recipe
    func getRecipeByFilters(filters: [String: Any]) async -> [Recipe] {
        
        var recipes: [Recipe] = []
        do {
            let collectionRef = db
            var query = collectionRef as Query
            for (field, value) in filters {
                query = query.whereField(field, isEqualTo: value)
            }
            
            let snapshot = try await query.getDocuments()
            
            for document in snapshot.documents {
                let recipe = try document.data(as: Recipe.self)
                recipes.append(recipe)
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        
        return recipes
    }
    
    func filterRecipeByTags(tags: [String]) async -> [Recipe] {
        var recipes: [Recipe] = []
        do {
            let collectionRef = db
            var query = collectionRef as Query
            let tagArray = tags.map { [$0] }
            print(tagArray)
            query = query.whereField("tags", in: tagArray)
            let snapshot = try await query.getDocuments()
            for d in snapshot.documents {
                let recipe = try d.data(as: Recipe.self)
                recipes.append(recipe)
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        print(recipes)
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
        return recipes
    }
    
    // MARK: Create new recipe
    func createNewRecipe(recipe: Recipe, backgroundImage: PhotosPickerItem?, cookingSteps: [CookingStepInterface]?) async {
        do {
            let recipeID = db.document().documentID
            try db.document(recipeID).setData(from: recipe)
            var backgroundURL = "default.jpeg"
            // If provided an image and successfully update the background image, set the backgroundURL in recipe
            if let backgroundImageData = backgroundImage {
                backgroundURL = try await uploadRecipeBGImage(data: backgroundImageData, recipeID: recipeID)
                
            }
            // Add cooking step and related image
            if cookingSteps != nil {
                for step in cookingSteps! {
                    let stepID = db.document().documentID
                    try await db.document(recipeID).collection("cookingSteps").document(stepID).setData(["context": step.context, "backgroundURL": backgroundURL, "stepNumber": step.stepNumber])
                    // Upload if the step contain image data
                    if let imageData = step.imageData {
                        try await uploadStepImage(data: imageData, recipeID: recipeID, stepID: stepID)
                    }
                }
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }

        
    }
    
    
    // MARK: Upload recipe background image
    func uploadRecipeBGImage(data: PhotosPickerItem, recipeID: String) async throws -> String {
        
        let resizedImageData = try await resizeImage(photoData: data, targetSize: CGSize(width: 450, height: 600))
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imageName = "\(recipeID)" + ".jpeg"
        let result = try await storage.child("recipeImage").child(imageName).putDataAsync(resizedImageData!, metadata: meta)
        guard let path = result.path else {
            throw RecipeManagerError.uploadImageFailed
        }
        try await db.document(recipeID).updateData(["backgroundURL": path])
        return path
    }
    
    func uploadStepImage(data: PhotosPickerItem, recipeID: String, stepID: String) async throws {
        let resizedImageData = try await resizeImage(photoData: data, targetSize: CGSize(width: 450, height: 600))
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imageName = "\(stepID)" + ".jpeg"
        let result = try await storage.child("recipeImage").child(imageName).putDataAsync(resizedImageData!, metadata: meta)
        guard let path = result.path else {
            throw RecipeManagerError.uploadImageFailed
        }
        try await db.document(recipeID).collection("cookingSteps").document(stepID).updateData(["backgroundURL": path])
    }
    
    
    // MARK: Delete recipe by ID
    func deleteRecipe(recipeID: String) async {
        do {
            if let recipe = await self.getRecipeInformation(recipeID: recipeID) {
                try await db.document(recipeID).delete()
                // Delete background image
                if !recipe.backgroundURL.isEmpty {
                    if recipe.backgroundURL != "default.jpeg" {
                        try await storage.child(recipe.backgroundURL).delete()
                    }
                }
            }
            
        } catch {
            print("DEBUG - \(error.localizedDescription)")
        }
    }
}

