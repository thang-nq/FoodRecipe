//
//  InputFieldManager.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import Foundation
import SwiftUI


class InputFieldManager: ObservableObject {
    
    //MARK: AUTHENTICATION LIMIT
    let emailLimit = 50
    let passwordLimit = 20
    let nameLimit = 20
    
    // published limit vars use in input field to restrict user input
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
    
    //MARK: VERIFY PASSWORD FORMAT
    var isPasswordFormat: Bool {
        let password = passwordInput
        let uppercaseLetterCharacterSet = CharacterSet.uppercaseLetters
        let decimalDigitCharacterSet = CharacterSet.decimalDigits
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/[]{}|")

        let containsUppercase = password.rangeOfCharacter(from: uppercaseLetterCharacterSet) != nil
        let containsDigit = password.rangeOfCharacter(from: decimalDigitCharacterSet) != nil
        let containsSpecialChar = password.rangeOfCharacter(from: specialCharacterSet) != nil
        return containsUppercase && containsDigit && containsSpecialChar
    }
    
    //MARK: AUTHENTICATION FEATURES
    
    // catch null input field varaibales for disable login button action
    func isValidLogin() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty
    }
    
    func isValidResetPW() -> Bool {
        return emailInput.isEmpty
    }
    
    // catch null input field varaibales for disable register button action
    func isValidRegister() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty || nameInput.isEmpty || repeatPWInput.isEmpty
    }
    
    // catch null input field varaibales for disable register button action
    func repeatNotMatch() -> Bool {
        if repeatPWInput == passwordInput {
            return false
        } else {
            return true
        }
    }
    
    //MARK: TDEE FEATURES
    
    //  published limit vars use in input field to restrict user input in TDEE FORM
    //  user must be type number to input weight, age and height
    @Published var ageInput = "" {
        didSet {
            let filtered = ageInput.filter { $0.isNumber }
            if ageInput != filtered {
                ageInput = filtered
            }
        }
    }
    
    @Published var heightInput = "" {
        didSet {
            let filtered = heightInput.filter { $0.isNumber }
            if heightInput != filtered {
                heightInput = filtered
            }
        }
    }
    
    @Published var weightInput = "" {
        didSet {
            let filtered = weightInput.filter { $0.isNumber }
            if weightInput != filtered {
                weightInput = filtered
            }
        }
    }
    
    // catch null input field varaibales for disable calculator button action
    func isValidBMIForm() -> Bool {
        return ageInput.isEmpty || heightInput.isEmpty || weightInput.isEmpty
    }
    
    
}
