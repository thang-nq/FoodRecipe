//
//  UserProfileMockView.swift
//  FoodRecipe
//
//  Created by Man Pham on 19/09/2023.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfileMockView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarViewRefresh: Bool = false
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var inputText: String = ""
    @State private var oldPassword: String = ""
    @State private var password: String = ""
    @State private var savedRecipe: [Recipe] = []
    @StateObject var homeVM = HomeViewModel()
    @StateObject var detailVM = RecipeDetailViewModel()
    @StateObject var tddeVM = TDDEViewModel()
    @StateObject var userProfileViewModel = UserProfileViewModel()
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
        NavigationView {
            VStack {
                top
                HStack {
                    SectionTitleView(title: "My Recipes")
                    //                Button {
                    //
                    //                } label: {
                    //
                    //                }
                    NavigationLink(destination: CreateRecipeView()) {
                        Text("Create recipe").foregroundColor(Color.theme.Orange).underline()
                    }
                    
                }
                Grid {
                    //                For index in 0...userProfileViewModel.recipeList.count {
                    //                    if(index % 2 == 0) {
                    //                        GridRow(
                    //                    }
                    //                }
                    
                    ForEach(Array(stride(from: 0, to: userProfileViewModel.recipeList.count, by: 2)), id: \.self) { index in
                        HStack {
                            GridRow {
                                CompactRecipeCard()
                                if(index + 1 < userProfileViewModel.recipeList.count) {
                                    CompactRecipeCard()
                                    //                        NutritionElementView(item: recipe.nutritionsArray[index+1])
                                }
                                if(index + 2 < userProfileViewModel.recipeList.count) {
                                    CompactRecipeCard()
                                    //                        NutritionElementView(item: recipe.nutritionsArray[index+1])
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                    //                GridRow {
                    //                    CompactRecipeCard()
                    //                    CompactRecipeCard()
                    //                }
                    //                GridRow {
                    //                    CompactRecipeCard()
                    //                    CompactRecipeCard()
                    //                }
                }
                Spacer()
            }
            .padding(16)
            .onAppear {
                Task {
                    await userProfileViewModel.getUserCreatedRecipe()
                }
            }
        }
    }
}

struct UserProfileMockView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileMockView()
    }
}

private extension UserProfileMockView {
    var top: some View {
        VStack {
            SectionTitleView(title: "User Profile Settings")
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nararaya Kirana")
                            .font(.custom("ZillaSlab-Regular", size: 26))
                            .kerning(0.552)
                            .foregroundColor(Color.theme.Black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text("nararaya.putri@mail.com")
                        //                            .foregroundColor()
                    }.padding(0)
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 60)
                        .background(
                            Image("soup")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipped()
                        )
                        .cornerRadius(60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .inset(by: -2.5)
                                .stroke(.white, lineWidth: 5)
                        )
                }
                Text("Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.")
            }
            .padding(.vertical, 16)
            .background(Color.theme.White)
            .shadow(color: Color.theme.Black.opacity(0.1), radius: 0, x: 0, y: -1)
            .shadow(color: Color.theme.Black.opacity(0.1), radius: 0, x: 0, y: 1)
        }
    }
}
