//
//  IntroView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI
import PhotosUI

struct IntroView: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var recipeName = ""
    @State private var minutes = ""
    @State private var hours = ""
    @State private var description = ""


    var body: some View {
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
//                        VStack{
//                            Text("Minutes")
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            TextField("Enter Minutes", text: $minute)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .padding(.trailing, 20)
//                        }
                        InputFieldRecipe(text: $minutes, title: "minutes", placeHolder: "Enter minutes")
                        Spacer()
//                        VStack{
//                            Text("Minutes")
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            TextField("Enter Minutes", text: $minute)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .padding(.trailing, 20)
//                        }
                        InputFieldRecipe(text: $hours, title: "hours", placeHolder: "Enter minutes")
                        
                    }
                    .padding(.top, 5)
                    
                    PhotosPicker(selection: $selectedPhoto, photoLibrary: .shared()) {
                        Label("Select a photo", systemImage: "photo.fill")
                    }.padding(.vertical, 10)
                    
                    HStack{
                        Text("Description")
                                .font(.custom("ZillaSlab-SemiBold", size: 22))
                                .padding(.leading, 15)
                        Spacer()
                    }
                    TextEditor(text: $description)
                        .font(.custom("ZillaSlab-Regular", size: 16))
                        .frame(height: 270)
                        .colorMultiply(.gray)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
