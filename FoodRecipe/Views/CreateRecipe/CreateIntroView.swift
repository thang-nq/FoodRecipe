//
//  CreateIntroView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI
import PhotosUI

struct CreateIntroView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var recipeName = ""
    @State private var minutes = ""
    @State private var description = ""

    var body: some View {
        ScrollView{
            VStack{
                //                    HStack{
                //                        Text("Title:")
                //                                .font(.custom("ZillaSlab-SemiBold", size: 26))
                //                                .padding(.leading, 20)
                //                        Spacer()
                //                    }
                InputFieldRecipe(text: $recipeName, title: "Title", placeHolder: "Enter title")
                //                    TextField(("Enter recipe name"), text: $recipeName)
                //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                //                        .font(.custom("ZillaSlab-Regular", size: 18))
                //                        .padding(.leading, 20)
                //                        .padding(.trailing, 20)
                HStack{
                    Text("Cook time")
                        .font(.custom("ZillaSlab-SemiBold", size: 22))
                        .padding(.leading, 15)
                    Spacer()
                }
                HStack{
                    
                    InputFieldRecipe(text: $minutes, title: "minutes", placeHolder: "Enter minutes")
                        .frame(width: 150)
                    Spacer()
                }
                
                .padding(.top, 5)
                
                PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                    Label("Select a photo for the recipe", systemImage: "photo.fill")
                }.padding(.vertical, 10)
                
                HStack{
                    Text("Description")
                        .font(.custom("ZillaSlab-SemiBold", size: 22))
                        .padding(.leading, 15)
                    Spacer()
                }
                TextEditor(text: $description)
                    .font(.custom("ZillaSlab-Regular", size: 16))
                    .frame(height: 250)
                    .colorMultiply(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct InputFieldRecipe: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("ZillaSlab-SemiBold", size: 22))
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            } else {
                TextField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            }
            
            Divider()
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
}

struct CreateIntroView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIntroView()
    }
}
