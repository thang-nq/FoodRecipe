//
//  Errors.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 13/09/2023.
//

import Foundation

enum RecipeManagerError: LocalizedError {
    case userNotLoggedIn // user is not logged in
    case uploadImageFailed
     
    var errorDescription: String? {
        switch self {
        case .userNotLoggedIn:
            return "Fetch recipe error: User is not logged in"
        case .uploadImageFailed:
            return "Failed to upload recipe image"
        }
    }
     
//    var failureReason: String? {
//        switch self {
//        case .userNotLoggedIn:
//            return "User is not logged in"
//        }
//    }
//
//    var recoverySuggestion: String? {
//        switch self {
//        case .userNotLoggedIn:
//            return "Please sign in first"
//        }
//    }
}
