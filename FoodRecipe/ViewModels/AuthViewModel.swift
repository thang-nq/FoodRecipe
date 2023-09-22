//
//  AuthViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//


import SwiftUI
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import PhotosUI


@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var storage = Storage.storage().reference()
    @Published private(set) var alertItem: AlertItem?
    @Published var showingAlert = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await UserManager.shared.signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            showingAlert = true
            alertItem = AlertItem(title: "Sign in error", message: error.localizedDescription, buttonTitle: "Dismiss")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await UserManager.shared.createUser(withEmail: email, password: password, fullName: fullName)
            self.userSession = result.user
            await fetchUser()
        } catch {
            showingAlert = true
            alertItem = AlertItem(title: "Signup error", message: error.localizedDescription, buttonTitle: "Dismiss")
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func changePassword(oldPassword oldpassword: String ,newPassword password: String) async throws {
        if let user = Auth.auth().currentUser {
            let credential = EmailAuthProvider.credential(withEmail: user.email!, password: oldpassword)
            try await user.reauthenticate(with: credential)
            try await Auth.auth().currentUser?.updatePassword(to: password)
        }
    }
    
    func signOut() {
        do {
            try UserManager.shared.signOut()
            self.userSession = nil // clear user session
            self.currentUser = nil // clear local user data
        } catch {
            print("DEBUG: Failed to signout with error \(error.localizedDescription)")
        }
    }
    
    func sendResetPasswordEmail(withEmail email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
    }
    
    func fetchUser() async {
        let userData = try? await UserManager.shared.fetchCurrentUser()
        self.currentUser = userData
    }
    
    func uploadAvatar(data: PhotosPickerItem) async throws -> String {
        if currentUser != nil {
            let resizedImageData = try await resizeImage(photoData: data, targetSize: CGSize(width: 200, height: 200))
            let meta = StorageMetadata()
            meta.contentType = "image/jpeg"
            let imageName = "\(currentUser!.id)" + ".jpeg"
            let result = try await storage.child("userAvatar").child(imageName).putDataAsync(resizedImageData!, metadata: meta)
            guard let path = result.path else {
                throw URLError(.badServerResponse)
            }
            try await Firestore.firestore().collection("users").document(currentUser!.id).updateData(["avatarUrl": path])
            return path
        }
        return ""
        
    }
    
    
    func fetchUserSavedRecipe() async -> [Recipe]{
        var recipes: [Recipe] = []
        if let userData = currentUser {
          recipes = await RecipeManager.shared.getUserSavedRecipes(userID: userData.id)
        }
        return recipes
    }
    
    //MARK: TEST TUAN
    let updateNameLimit = 20
    let oldPWLimit = 20
    let updatePWLimit = 20
    
    @Published var updateName = "" {
        didSet {
            if updateName.count > updateNameLimit {
                updateName = String(updateName.prefix(updateNameLimit))
            }
        }
    }
    
    @Published var updatePW = "" {
        didSet {
            if updatePW.count > updatePWLimit {
                updatePW = String(updatePW.prefix(updatePWLimit))
            }
        }
    }
    
    @Published var confirmUpdatePW = "" {
        didSet {
            if confirmUpdatePW.count > updatePWLimit {
                confirmUpdatePW = String(confirmUpdatePW.prefix(updatePWLimit))
            }
        }
    }
    

    @Published var oldPW = "" {
        didSet {
            if oldPW.count > oldPWLimit {
                oldPW = String(oldPW.prefix(oldPWLimit))
            }
        }
    }
    
    func isValidUpdatePW() -> Bool {
        return oldPW.isEmpty || updatePW.isEmpty || confirmUpdatePW.isEmpty || updatePW != confirmUpdatePW
    }
    
    func isValidUpdateName() -> Bool {
        return updateName.isEmpty
    }
    
    
}

