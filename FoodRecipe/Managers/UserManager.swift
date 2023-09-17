//
//  AuthManager.swift
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

struct AuthDataResultModel {
    let UID: String
    let email: String
    let photoURL: String?
    
}

final class UserManager {
    static let shared = UserManager()
    private(set) var currentUser: User? = nil
    private var db = Firestore.firestore().collection("users")
    private var storage = Storage.storage().reference()
    
    private init() {
        Task {
            try? await fetchCurrentUser()
        }
    }
    
    func getUserData(userID: String) async -> User? {
        var user: User? = nil
        do {
            let document = try await db.document(userID).getDocument()
            user = try document.data(as: User.self)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        return user
    }
    
    func updateUser(userID: String, updateValues: [String: Any]) async throws {
        if let user = await self.getUserData(userID: userID) {
            try await db.document(user.id).updateData(updateValues)
        } else {
            throw UserManagerError.userIDNotFound
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = await getUserData(userID: result.user.uid)
            self.currentUser = user
            return result
    }
    
    func signOut() throws {
            try Auth.auth().signOut() // sign out user in the firebase
            self.currentUser = nil // clear local user data
    }
    
    func fetchCurrentUser() async throws -> User? {
        if let uid = Auth.auth().currentUser?.uid {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        }
        return self.currentUser
    }
    
    func getCurrentUserData() async throws -> User? {
        var user: User? = nil
        if currentUser != nil {
            user = await getUserData(userID: self.currentUser!.id) 
        } else {
            throw RecipeManagerError.userNotLoggedIn
        }
        
        return user
    }
    
    
    
    

    
}
