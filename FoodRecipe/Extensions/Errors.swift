/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import Foundation

// Custom error

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
}


enum UserManagerError: LocalizedError {
    case userIDNotFound
    case requireLoginWithEmailFirst
    case faceIDNotSupport
    
    var errorDescription: String? {
        switch self {
        case .userIDNotFound:
            return "Fetch user data error: User ID not found"
        case .requireLoginWithEmailFirst:
            return "Require to login with email to use Face ID"
        case .faceIDNotSupport:
            return "Your phone does not support or not enable Face ID"
        }
    }
}
