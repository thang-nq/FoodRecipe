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
    private var db = Firestore.firestore().collection("users")
    private var storage = Storage.storage().reference()
    
    private init() {
        
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
    

    
}
