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
    @StateObject var tddeViewModel = TDDEViewModel.shared
    @State private var navigateToPersonalTDEE = false
    @AppStorage("isDarkMode") var isDark = false
    
    //MARK: POP UP VARIABLES
    @State var showPopUp = false
    @State var popUpIcon = ""
    @State var popUptitle = ""
    @State var popUpContent = ""
    @State var popUpIconColor = Color.theme.BlueInstance
    
    //MARK: init font cus nav title
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ZillaSlab-Bold", size: 30)!]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.Orange)]
//    }
//
    var body: some View {
        NavigationStack{
            VStack{
                title
                form
                submitButton
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: ExitButton())
            .overlay(
                ZStack {
                    if showPopUp {
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                    }
                }
            )
            .toolbar {
            // MARK: Tool Bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isDark.toggle() }) {
                        isDark ? Label("Dark", systemImage: "lightbulb.fill") :
                        Label("Dark", systemImage: "lightbulb")
                    }
                    .foregroundColor(Color.theme.OrangeInstance)
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
    
}

private extension TDDEFormView {
    
    //MARK: TITLE
    var title: some View {
        Text("TDEE CALCULATOR")
            .font(Font.custom.NavigationTitle)
    }
    
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
    }
    
    
    //MARK: SUBMIT BUTTON
    var submitButton: some View {
        Button(action:{
            //Convert age and height string to INT & DOUBLE
            let ageInt = (inputFieldManager.ageInput as NSString).integerValue
            let heightInt = (inputFieldManager.heightInput as NSString).integerValue
            let weightInt = (inputFieldManager.weightInput as NSString).integerValue
//            print("AGE: \(ageInt); HEIGHT: \(heightInt); GENDER: \(gender); ACTIVITY LEVEL: \(activityLevel); WEIGHT: \(weightInt) ")
            
            Task {
                await tddeViewModel.calculateTDDE(age: ageInt, height: heightInt, weight: weightInt, gender: gender, activityLevel: activityLevel)
            }
    
            popUpIcon = "figure.dance"
            popUptitle = "Calculate new TDEE success"
            popUpContent = "Please back to TDEE screen to view new update nutritions suggest"
            showPopUp = true
            
            
//            navigateToPersonalTDEE = true
            
            
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
//        .navigationDestination(isPresented: $navigateToPersonalTDEE){
////            TDEEPersonalView()
//        }
    }
    
    //MARK: BACK BUTTON
    
        
        
}
