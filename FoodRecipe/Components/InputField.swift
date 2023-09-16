//
//  InputField.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureField = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("ZillaSlab-SemiBold", size: 20))
                .foregroundColor(Color(.darkGray))
            
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            } else {
                TextField(placeHolder, text: $text)
                    .font(.custom("ZillaSlab-Regular", size: 16))
            }
            
            Divider()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField(text: .constant(""), title: "Email Address", placeHolder: "name@gmail.com")
    }
}
