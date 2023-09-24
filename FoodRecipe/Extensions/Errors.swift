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
