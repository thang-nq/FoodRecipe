//
//  InputFieldManager.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import Foundation
import SwiftUI


class InputFieldManager: ObservableObject {
    
    let emailLimit = 50
    let passwordLimit = 20
    let nameLimit = 20
    
    @Published var emailInput = "" {
        didSet {
            if emailInput.count > emailLimit {
                emailInput = String(emailInput.prefix(emailLimit))
            }
        }
    }
    
    @Published var passwordInput = "" {
        didSet {
            if passwordInput.count > passwordLimit {
                passwordInput = String(passwordInput.prefix(passwordLimit))
            }
        }
    }
    
    @Published var nameInput = "" {
        didSet {
            if nameInput.count > nameLimit {
                nameInput = String(nameInput.prefix(nameLimit))
            }
        }
    }
    
    @Published var repeatPWInput = "" {
        didSet {
            if repeatPWInput.count > passwordLimit {
                repeatPWInput = String(repeatPWInput.prefix(passwordLimit))
            }
        }
    }
    
    var isPasswordFormat: Bool {
        let password = passwordInput
        let uppercaseLetterCharacterSet = CharacterSet.uppercaseLetters
        let decimalDigitCharacterSet = CharacterSet.decimalDigits
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/[]{}|")
        
        let containsUppercase = password.rangeOfCharacter(from: uppercaseLetterCharacterSet) != nil
        let containsDigit = password.rangeOfCharacter(from: decimalDigitCharacterSet) != nil
        let containsSpecialChar = password.rangeOfCharacter(from: specialCharacterSet) != nil
        
//        print(containsUppercase && containsDigit && containsSpecialChar)
        return containsUppercase && containsDigit && containsSpecialChar
    }
    
    
    func isValidLogin() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty
    }
    
    func isValidRegister() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty || nameInput.isEmpty || repeatPWInput.isEmpty
    }
}
