/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 13/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

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
            self.currentUser = user
        } else {
            throw UserManagerError.userIDNotFound
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws -> AuthDataResult {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let newUser = User(id: result.user.uid, fullName: fullName, email: email)
        let encodedUser = try Firestore.Encoder().encode(newUser)
        try await Firestore.firestore().collection("users").document(newUser.id).setData(encodedUser)
        try await Auth.auth().currentUser?.sendEmailVerification()
        return result
        
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
