//
//  UserProfileMockView.swift
//  FoodRecipe
//
//  Created by Man Pham on 19/09/2023.
//

import SwiftUI

struct UserProfileMockView: View {
    var body: some View {
        VStack {
            top
            HStack {
                SectionTitleView(title: "My Recipes")
                Button {
                    
                } label: {
                    Text("View all").foregroundColor(Color.theme.Orange).underline()
                }
                
            }
            Grid {
                GridRow {
                    CompactRecipeCard()
                    CompactRecipeCard()
                }
                GridRow {
                    CompactRecipeCard()
                    CompactRecipeCard()
                }
            }
            Spacer()
        }.padding(16)
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