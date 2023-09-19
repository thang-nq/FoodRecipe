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
            Text("User Profile Settings")
                .font(.custom("ZillaSlab-Bold", size: 26)).fontWeight(.medium)
                .kerning(0.552)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nararaya Kirana")
                            .font(.custom("ZillaSlab-Regular", size: 26))
                            .kerning(0.552)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text("nararaya.putri@mail.com")
                            .foregroundColor(.black)
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
            Spacer()
        }
    }
}
