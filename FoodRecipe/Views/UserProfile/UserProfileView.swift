//
//  UserProfileView.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import LocalAuthentication

struct UserProfileView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarViewRefresh: Bool = false
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var inputText: String = ""
    @State private var oldPassword: String = ""
    @State private var password: String = ""
    @State private var savedRecipe: [Recipe] = []
    @State private var unlocked: Bool = false
    @StateObject var homeVM = HomeViewModel()
    @StateObject var detailVM = RecipeDetailViewModel()
    @StateObject var tddeVM = TDDEViewModel.shared
    @StateObject var userProfileVM = UserProfileViewModel()
    // MARK: change to environment object when demo
//    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    
    func bioAuthenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use Face ID to access your account data on this device") { success, authenticationError in
                if success {
                    unlocked = true
                } else {
                    print("There was a problem when auth by faceid")
                }
            }
        }
        
    }
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            VStack{
                VStack {
                    // MARK: WIREFRAME USER DATA
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        if user.avatarUrl.isEmpty {
                            emptyAvatar(initials: user.initials)
                        } else {
                            UserAvatar(imagePathName: user.avatarUrl)
                                .frame(width: 200, height: 200)
                                .id(avatarViewRefresh)
                            
                        }
                    }
                    
                    userData(fullName: user.fullName, email: user.email)
                    if unlocked {
                        Text("Unlocked by faceID")
                    } else {
                        Text("Not yet unlocked")
                    }
                    signOutButton
                    
                    Button {
                        bioAuthenticate()
                    } label: {
                         Text("Face ID")
                    }
                    
                    
                    //MARK: change password
                    
//                    InputField(text: $oldPassword, title: "Old password", placeHolder: "enter old password")
//                    InputField(text: $password, title: "New password", placeHolder: "enter new password")
//
//                    Button {
//                        Task {
//                            await viewModel.changePassword(oldPassword: oldPassword, newPassword: password)
//                        }
//                    } label: {
//                        Text("Change password")
//                    }
//
//                    Button {
//                        Task {
//                            await viewModel.sendResetPasswordEmail(withEmail: "latuan2906@gmail.com")
//                        }
//                    } label: {
//                        Text("Send reset pw email")
//                    }
                }
                
                
                // MARK: Update recipe
                ScrollView {
                    VStack (alignment: .center) {
                        if let recipe = detailVM.recipe {
                            Button {
                                Task {
                                    // Update entire recipe and re-define cooking steps (overwrite old cookingSteps)
                                    await detailVM.updateRecipe(recipeID: recipe.id!, updateData: updateRecipeInterface(name: "Updated recipe and steps", mealType: "UpdatedMealtype", backgroundImage: stepPhoto, steps: [CookingStepInterface(context: "New step context", imageData: stepPhoto, stepNumber: 1)]))
                                }
                            } label: {
                                Text("Update recipe")
                            }
                            FirebaseImage(imagePathName: recipe.backgroundURL).frame(width: 200, height: 150)
                                .padding(.bottom)
                            Text(recipe.name)
                            HStack(alignment: .center) {
                                Text("Created by - \(recipe.creatorName)")
                                UserAvatar(imagePathName: recipe.creatorAvatar).frame(width: 25, height: 25)
                            }
                            Text("Created at - \(recipe.createdAt)")
                            Text("Mealtype - \(recipe.mealType)")
                            Text(recipe.mealType)
                            ForEach(recipe.steps) { step in


                                Text("Step \(step.stepNumber) - \(step.context)")
                                FirebaseImage(imagePathName: step.backgroundURL).frame(width: 150, height: 100)
                                    .padding(.bottom)


                                Button {
                                    Task {

                                        // MARK: Update a step
                                        await detailVM.updateCookingStep(recipeID: recipe.id!, stepID: step.id!, context: "This step is updated", backgroundImage: stepPhoto)
                                    }
                                } label: {
                                    Text("Update this step")
                                }


                                // MARK: Delete a step
                                Button {
                                    Task {
                                        await detailVM.deleteCookingStep(recipeID: recipe.id!, stepID: step.id!)
                                    }
                                } label: {
                                    Text("Delete this step").foregroundColor(.red)
                                }
                            }
                        } else {

                        }
                        
//                        ForEach(userProfileVM.recipeList) { recipe in
//                            Text("Name - \(recipe.name)")
//                            Button {
//                                Task {
//
//                                }
//                            } label: {
//                                 Text("Remove from list")
//                            }
//                        }.task {
//                            await userProfileVM.getUserCreatedRecipe()
//                        }
                    }
                }

                
//                ScrollView {
//                    VStack {
//                        Text("Saved recipes")
//                        ForEach(homeVM.savedRecipes) {recipe in
//                            VStack {
//                                Text(recipe.name)
//                                Text("Created by - \(recipe.creatorName)")
//                                Text(recipe.isSaved ? "Already saved" : "Save to favorite")
//                                Button {
//                                    Task {
//                                        await homeVM.saveOrRemoveRecipe(recipeID: recipe.id!)
//                                    }
//                                } label: {
//                                    Text("🗑️ Unsave")
//                                }
//                            }
//
//                        }
//                    }
//
//                }
//                .task {
//                    await homeVM.getSavedRecipe()
//                }

                
                
                // MARK: RECIPE WRAPPER
                
                // recipe detail

                
                
                // Recipe list
                
                PhotosPicker(selection: $stepPhoto, photoLibrary: .shared()) {
                    Label("Choose step photo", systemImage: "photo")
                }
                
                Button {
                    Task {
                        
                        // Add new recipe and image to firebase
                        // Using CookingStepInterface to init
                        // If no imagedata is provided to the steps, it will get the backgroundURL of recipe as default.
                        // Step number is important to maintain the order
                        try await homeVM.addRecipe(recipe: Recipe(name: "Crispy Pork",
                                                                  creatorID: user.id,
                                                                  intro: "This is a healthy dish",
                                                                  servingSize: 3,
                                                                  cookingTime: 90,
                                                                  calories: 740,
                                                                  carb: 15,
                                                                  protein: 30,
                                                                  ingredients: ["300g Pork", "20g Salt"],
                                                                  tags: ["Pork", "Dinner"]),
                                                   image: stepPhoto,
                                                   cookingSteps: [
                                                    CookingStepInterface(context: "Prepare the ingredient", imageData: nil, stepNumber: 1),
                                                    CookingStepInterface(context: "Cook the meal", imageData: nil, stepNumber: 2),
                                                    CookingStepInterface(context: "Divide the meal", imageData: nil, stepNumber: 3),
                                                    CookingStepInterface(context: "Let's eat", imageData: nil, stepNumber: 4)]
                        )
                    }
                } label: {
                    Text("Add new recipe")
                        .foregroundColor(.green)
                }
                
                
//                Button {
//                    Task {
////                        await homeVM.searchRecipeByTags(tags: ["Chicken", "Pork"])
//                        await homeVM.searchRecipeByText(text: inputText)
//                    }
//                } label: {
//                    Text("Search")
//                }
//
//                InputField(text: $inputText, title: "Search Field", placeHolder: "Type here")
                
                Divider()
                ScrollView {
                    VStack {
                        ForEach(homeVM.recipes) {recipe in
                            VStack {
                                Text(recipe.name)
                                Text("Created by - \(recipe.creatorName)")
                                
                                Button {
                                    Task {
//                                        await homeVM.saveOrRemoveRecipe(recipeID: recipe.id!)
                                        await homeVM.addRecipeToTDDE(recipeID: recipe.id!)
                                        await tddeVM.getTDDERecipe()
                                    }
                                } label: {
                                    Text(recipe.isSaved ? "Remove save" : "Save to favorite ♥️")
                                }
                                Button {
                                    Task {
                                        await detailVM.getRecipeDetail(recipeID: recipe.id!)
                                    }
                                } label: {
                                    Text("View detail")
                                }
                                Button {
                                    Task {
                                        try await homeVM.deleteRecipe(recipeID: recipe.id!)
                                    }
                                } label: {
                                    Text("Delete").foregroundColor(.red)
                                }
                            }
                            
                        }
                    }
                    
                }
                .task {
                    await homeVM.getAllRecipe()
                }
                
                
                
                
            }
            .overlay(
                ZStack {
                    if showPopUp {
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                    }
                }
                    .opacity(showPopUp ? 1 : 0)
            )
            .onChange(of: selectedPhoto, perform: { newValue in
                if let newValue {
                    
                    // CALL POP UP
                    showPopUp = true
                    popUpIcon = "checkmark.message.fill"
                    popUptitle = "Upload avatar success"
                    popUpContent = "If you have any more requests or need further assistance, feel free to ask!, If you have any more requests or need further assistance, feel free to ask!"
                    popUpIconColor = Color.theme.GreenInstance
                    
                    Task {
                        try await viewModel.uploadAvatar(data: newValue)
                        await viewModel.fetchUser()
                        avatarViewRefresh.toggle()
                    }
                }
            })
            .onAppear {
                
            }
        }
        
    }
}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(AuthViewModel())
    }
}



private extension UserProfileView {
    
    // MARK: USER AVATAR
    func emptyAvatar(initials: String) -> some View {
        Text(initials)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 72, height: 72)
            .background(Color(.systemGray3))
            .clipShape(Circle())
    }
    
    // MARK: USER NAME AND EMAIL
    func userData(fullName: String, email: String) -> some View  {
        VStack (alignment:.leading, spacing: 4) {
            Text(fullName)
                .fontWeight(.semibold)
                .padding(.top, 4)
            
            Text(email)
                .font(.footnote)
                .foregroundColor(.blue)
        }
    }
    
    //MARK: LOGOUT BUTTON UI
    var signOutButton: some View {
        Button {
            viewModel.signOut()
        } label: {
            Text("Sign out")
                .foregroundColor(.red)
        }
    }
    
    
    
}
