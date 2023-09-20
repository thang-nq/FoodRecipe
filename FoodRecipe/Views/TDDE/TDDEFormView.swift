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
    @State private var activityLevel: Double = 1.2
    @ObservedObject var inputFieldManager = InputFieldManager()
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = true
    @StateObject var tddeViewModel = TDDEViewModel()
//    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToPersonalTDEE = false
    
    //MARK: init font cus nav title
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.Orange)]
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                form
                submitButton
            }
//            .navigationBarTitle("TDEE CALCULATOR", displayMode: .large)
            .navigationTitle(Text("TDEE CALCULATOR"))
            .navigationBarBackButtonHidden(true)
        }
        .fullScreenCover(isPresented: $TDDEIntro, content: {
            TDEEWelcomeList()
        })
    }
    
}

//struct TDDEFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        TDDEFormView()
//    }
//}

private extension TDDEFormView {
    //MARK: FORM UI
    var form: some View {
        
        List {
            //MARK: GENDER UI
            Section {
                Picker("Gender", selection: $gender){
                    Text("Male")
                        .tag("MALE")
                    Text("Female")
                        .tag("FEMALE")
                }
                .font(Font.custom.Content)
                .foregroundColor(Color.theme.DarkBlue)

            } header: {
                Text("Select your gender")
                    .font(Font.custom.SubHeading)
                    .foregroundColor(Color.theme.DarkBlue)
            }
            
            //MARK: AGE UI
            Section(header: Text("Your age")) {
                TextField("Your age", text: $inputFieldManager.ageInput)
                    .font(Font.custom.ContentItalic)
                    .keyboardType(.decimalPad)
            }
            .font(Font.custom.SubHeading)
            .foregroundColor(Color.theme.DarkBlue)
            
            //MARK: HEIGHT UI
            Section(header: Text("Your height")) {
                TextField("Your height (cm)", text: $inputFieldManager.heightInput)
                    .font(Font.custom.ContentItalic)
                    .keyboardType(.decimalPad)
            }
            .font(Font.custom.SubHeading)
            .foregroundColor(Color.theme.DarkBlue)
        
            //MARK: HEIGHT UI
            Section(header: Text("Your weight")) {
                TextField("Your weight (kg)", text: $inputFieldManager.weightInput)
                    .font(Font.custom.ContentItalic)
                    .keyboardType(.decimalPad)
            }
            .font(Font.custom.SubHeading)
            .foregroundColor(Color.theme.DarkBlue)
            
            //MARK: ACTIVITY LEVEL
            Section{
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
                .font(Font.custom.Content)
                .foregroundColor(Color.theme.DarkBlue)
                
            } header: {
                Text("Select your activity level")
                    .font(Font.custom.SubHeading)
                    .foregroundColor(Color.theme.DarkBlue)
            } footer: {
                Text("Activity level is a factor that is based on the amount of activity a person undergoes. This includes deliberate exercise as well as other activities that a person may undergo as part of their job or typical daily activities. These factors are more specifically referred to as the thermic effect of activity, and non-exercise activity thermogenesis (energy expended for non-sleeping, eating, or sports-like exercise).")
                    .font(Font.custom.SubContent)
                    .foregroundColor(Color.theme.DarkGray)
            }
        }
//        .listStyle(.sidebar)
    }
    
    
    //MARK: SUBMIT BUTTON
    var submitButton: some View {
        Button(action:{
            //Convert age and height string to INT & FLOAT
            let ageInt = (inputFieldManager.ageInput as NSString).integerValue
            let heightInt = (inputFieldManager.heightInput as NSString).integerValue
            let weightInt = (inputFieldManager.weightInput as NSString).integerValue
            
            print("AGE: \(ageInt); HEIGHT: \(heightInt); GENDER: \(gender); ACTIVITY LEVEL: \(activityLevel); WEIGHT: \(weightInt) ")
            Task {
                await tddeViewModel.calculateTDDE(age: ageInt, height: heightInt, weight: weightInt, gender: gender, activityLevel: activityLevel)
                
            }
            navigateToPersonalTDEE = true
            
        }){
            Text("CALCULATE")
                .font(Font.custom.ButtonText)
                .frame(width: 350, height: 50)
                .contentShape(Rectangle())
        }
        .foregroundColor(Color.theme.DarkBlueInstance)
        .background(inputFieldManager.isValidBMIForm() ? Color.theme.LightGray: Color.theme.Orange)
        .cornerRadius(8)
        .disabled(inputFieldManager.isValidBMIForm())
        .navigationDestination(isPresented: $navigateToPersonalTDEE){
//            TDEEPersonalView()
        }
    }
        
        
}
