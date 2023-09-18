//
//  BMIFormView.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 17/09/2023.
//

import SwiftUI


struct TDDEFormView: View {
    
    //MARK: USER VARAIBLES
    @State private var gender: String = "MALE"
    @State private var activityLevel: Float = 1.2
    @ObservedObject var inputFieldManager = InputFieldManager()
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = true
    @State private var navigateToPersonalTDEE = false
    
    //MARK: init font cus nav title
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                form
            }
            .navigationTitle(Text("TDEE CALCULATOR"))
            .navigationBarBackButtonHidden(true)
        }
        .fullScreenCover(isPresented: $TDDEIntro, content: {
            TDEEWelcomeList()
        })
    }
    
}

struct TDDEFormView_Previews: PreviewProvider {
    static var previews: some View {
        TDDEFormView()
    }
}

private extension TDDEFormView {    
    //MARK: TITLE UI
    var title: some View {
            Text("TDEE CALCULATOR")
                .font(.custom("ZillaSlab-BoldItalic", size: 30))
    }
    
    //MARK: FORM UI
    var form: some View {
        
        Form {
            //MARK: GENDER UI
            Section(header: Text("Select your gender")){
                Picker("Gender", selection: $gender){
                    
                    Text("Male")
                        .tag("MALE")
                    
                    Text("Female")
                        .tag("FEMALE")
                        
                }
                .font(.custom("ZillaSlab-BoldItalic", size: 16))
                .foregroundColor(Color.theme.DarkBlue)
            }
            .font(.custom("ZillaSlab-Bold", size: 18))
            .foregroundColor(Color.theme.DarkBlue)

            //MARK: AGE UI
            Section(header: Text("Your age")) {
                TextField("Your age", text: $inputFieldManager.ageInput)
                    .font(.custom("ZillaSlab-MediumItalic", size: 16))
                    .keyboardType(.decimalPad)
            }
            .font(.custom("ZillaSlab-Bold", size: 18))
            .foregroundColor(Color.theme.DarkBlue)
            
            //MARK: HEIGHT UI
            Section(header: Text("Your height")) {
                TextField("Your height (cm)", text: $inputFieldManager.heightInput)
                    .font(.custom("ZillaSlab-MediumItalic", size: 16))
                    .keyboardType(.decimalPad)
            }
            .font(.custom("ZillaSlab-Bold", size: 18))
            .foregroundColor(Color.theme.DarkBlue)
            
            //MARK: ACTIVITY LEVEL
            Section(header: Text("Select your activity level")){
                Picker("Activity level", selection: $activityLevel){
                    Text("Sedentary")
                        .tag(1.2)
                    
                    Text("Light")
                        .tag(1.375)
                    
                    Text("Moderate")
                        .tag(1.55)
                    
                    Text("Active")
                        .tag(1.725)
                    
                    Text("Very Active")
                        .tag(1.9)
                }
                .font(.custom("ZillaSlab-BoldItalic", size: 16))
                .foregroundColor(Color.theme.DarkBlue)
                
                Text("Activity level is a factor that is based on the amount of activity a person undergoes. This includes deliberate exercise as well as other activities that a person may undergo as part of their job or typical daily activities. These factors are more specifically referred to as the thermic effect of activity, and non-exercise activity thermogenesis (energy expended for non-sleeping, eating, or sports-like exercise).")
                    .font(.custom("ZillaSlab-Regular", size: 16))
                    .foregroundColor(Color.theme.DarkGray)
            }
            .font(.custom("ZillaSlab-Bold", size: 18))
            .foregroundColor(Color.theme.DarkBlue)
            
            //MARK: SUBMIT BUTTON
            
            Button(action:{
                //Convert age and height string to INT & FLOAT
                let ageInt = (inputFieldManager.ageInput as NSString).integerValue
                let heightInt = (inputFieldManager.heightInput as NSString).integerValue
                print("AGE: \(ageInt); HEIGHT: \(heightInt); GENDER: \(gender); ACTIVITY LEVEL: \(activityLevel)")
                navigateToPersonalTDEE = true
            }){
                Text("Submit")
                    .font(.custom("ZillaSlab-SemiBoldItalic", size: 20))
                    .frame(width: 350, height: 50)
                    .contentShape(Rectangle())
            }
            .foregroundColor(Color.theme.DarkBlueInstance)
            .background(inputFieldManager.isValidBMIForm() ? Color.theme.LightGray: Color.theme.Orange)
            .cornerRadius(8)
            .disabled(inputFieldManager.isValidBMIForm())
            .navigationDestination(isPresented: $navigateToPersonalTDEE){
                TDEEPersonalView()
            }
        }
    }
        
    
}
