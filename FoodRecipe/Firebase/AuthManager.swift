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

final class AuthManager {
    static let shared = AuthManager()
    private(set) var alertItem: AlertItem?
    
    private init() {
    }
    

    
}
