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

struct UserProfileView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarPath: String = ""
    @State private var avatarViewRefresh: Bool = false
    @State private var stepPhoto: PhotosPickerItem? = nil
    @StateObject var homeVM = HomeViewModel()
    @StateObject var detailVM = RecipeDetailViewModel()
    // MARK: change to environment object when demo
//    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            VStack{
                VStack {
                    // MARK: WIREFRAME USER DATA
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        if user.avatarUrl.isEmpty {
                            emptyAvatar(initials: user.initials)
                        } else {
                            UserAvatar(imagePathName: $avatarPath)
                                .id(avatarViewRefresh)
                        }
                    }
                    
                    userData(fullName: user.fullName, email: user.email)
                    signOutButton
                }
                
                // MARK: RECIPE WRAPPER
                
                // recipe detail
                ScrollView {
                    VStack (alignment: .center) {
                        if let recipe = detailVM.recipe {
                            FirebaseImage(imagePathName: recipe.backgroundURL).frame(width: 200, height: 150)
                                .padding(.bottom)
                            Text(recipe.name)
                            Text(recipe.mealType)
                            ForEach(recipe.steps) { step in
                                Text("Step \(step.stepNumber) - \(step.context)")
                                FirebaseImage(imagePathName: step.backgroundURL).frame(width: 150, height: 100)
                                    .padding(.bottom)
                            }
                        } else {
                            
                        }
                    }
                }

                
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
                Button {
                    Task {
                        try await homeVM.getRecipeByMealType(mealType: "Breakfast")
                    }
                } label: {
                    Text("Get all breakfast")
                }
                Divider()
                ScrollView {
                    VStack {
                        ForEach(homeVM.recipes) {recipe in
                            HStack {
                                Text(recipe.name)
                                Button {
                                    Task {
                                        try await detailVM.getRecipeDetail(recipeID: recipe.id!)
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
                .onAppear {
                    Task {
                        try await homeVM.getAllRecipe()
                    }
                }

                //
                
                
                
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
                        avatarPath = try await viewModel.uploadAvatar(data: newValue)
                        avatarViewRefresh.toggle()
                    }
                }
            })
            .onAppear {
                avatarPath = viewModel.currentUser?.avatarUrl ?? ""
            }
        } else {
            Text("Not logged in")
        }
        
    }
}


//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//            
//    }
//}


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
