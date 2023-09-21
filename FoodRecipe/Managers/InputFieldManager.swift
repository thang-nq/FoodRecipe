//
//  InputFieldManager.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import Foundation
import SwiftUI


class InputFieldManager: ObservableObject {
    
    //MARK: AUTHENTICATION VARIABLES
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
    
    //MARK: SKIP VERIFY PASSWORD FORMAT FOR UX
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
    
    func isValidLogin() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty
    }
    
    func isValidRegister() -> Bool {
        return emailInput.isEmpty || passwordInput.isEmpty || nameInput.isEmpty || repeatPWInput.isEmpty
    }
    
    func repeatNotMatch() -> Bool {
        if repeatPWInput == passwordInput {
            return false
        } else {
            return true
        }
    }
    
    
    //MARK: BMI FEATURES
    
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
    
    func isValidBMIForm() -> Bool {
        return ageInput.isEmpty || heightInput.isEmpty || weightInput.isEmpty
    }
    
    
}
