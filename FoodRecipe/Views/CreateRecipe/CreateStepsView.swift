//
//  CreateStepsView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import PhotosUI

struct CreateStepsView: View {
    @AppStorage("isDarkMode") var isDark = false
    //MARK: VARIABLES
    @Binding var Steps: [String]
    @Binding var listStepsPhoto: [PhotosPickerItem?]
    @Binding var backgroundPhoto: PhotosPickerItem?
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var showingSheet = false
    @State private var showingUpdateSheet = false
    @State private var InputStep = ""
    @State private var updateStep = ""
    @State private var updatePhoto : PhotosPickerItem? = nil
    @State private var showPopUp = false
    @State private var popUpIcon = ""
    @State private var popUptitle = ""
    @State private var popUpContent = ""
    @State private var popUpIconColor = Color.theme.BlueInstance
    
    private func updateStepFunction(step: String, photo: PhotosPickerItem?) {
        updateStep = step
        updatePhoto = photo
        showingUpdateSheet.toggle()
    }
    var body: some View {
        //MARK: MAIN LAYOUT
        
        VStack{
            ScrollView{
                steps
                    .accessibilityLabel("Steps")
            }
        }
        .sheet(isPresented: $showingSheet){
            // MARK: ADD STEP SHEET UI
            AddStepsSheetView(InputStep: $InputStep, Steps: $Steps, stepPhoto: $stepPhoto, listStepsPhoto: $listStepsPhoto, backgroundPhoto: $backgroundPhoto)
                .presentationDetents([.height(300)])
                .presentationBackground(isDark ? Color.theme.DarkWhite.opacity(0.2) : Color.theme.White)
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
        .sheet(isPresented: $showingUpdateSheet){
            // MARK: UPDATE STEP SHEET UI
            UpdateStepsSheetView(Steps: $Steps, listStepsPhoto: $listStepsPhoto,updateStep: $updateStep, updatePhoto: $updatePhoto, showingUpdateSheet: $showingUpdateSheet)
                .presentationDetents([.height(300)])
                .presentationBackground(isDark ? Color.theme.DarkWhite.opacity(0.2) : Color.theme.White)
                .environment(\.colorScheme, isDark ? .dark : .light)
        }
        .frame(maxWidth: 500, maxHeight: .infinity, alignment: .topLeading)
        .overlay(
        // MARK: SHOW THE SUCCESS POP UP
            ZStack {
                if showPopUp {
                    Color.theme.DarkWhite.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    PopUp(iconName: popUpIcon , title: popUptitle, content: popUpContent, iconColor: popUpIconColor ,didClose: {showPopUp = false})
                }
            }
                .opacity(showPopUp ? 1 : 0)
        )
        .overlay(
            //MARK: ADD STEPS BUTTON
            Button(action: {
                if backgroundPhoto == nil{
                    showPopUp = true
                    popUpIcon = "xmark"
                    popUptitle = "Missing Recipe Photo"
                    popUpContent = "Please choose the photo for the recipe in the Intro Section"
                    popUpIconColor = Color.theme.RedInstance
                } else{
                    self.showingSheet.toggle()
                }
            }, label: {
                Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(Color.theme.WhiteInstance)
                                .padding(20)
                                .background(Color.theme.OrangeInstance)
                                .clipShape(Circle())
                                
            })
            .modifier(ButtonModifier()),
            alignment: .bottomTrailing
            
        )
        
    }
}

//MARK: ADD STEP SHEET VIEW
struct AddStepsSheetView: View {
    @Binding var InputStep : String
    @Binding var Steps : [String]
    @Binding var stepPhoto: PhotosPickerItem?
    @Binding var listStepsPhoto : [PhotosPickerItem?]
    @Binding var backgroundPhoto: PhotosPickerItem?
    var body: some View{
        VStack{
            InputFieldRecipe(text: $InputStep , title: "Step", placeHolder: "Enter step")
        }
        
        PhotosPicker(selection: $stepPhoto, photoLibrary: .shared()) {
            Label("Select a photo for step", systemImage: "photo.fill")
        }
        .padding(.vertical, 10)
        .foregroundColor(Color.theme.OrangeInstance)
            Button(action: {
                if(!InputStep.isEmpty){
                    Steps.append(InputStep)
                }
                if let photo = stepPhoto {
                    listStepsPhoto.append(photo)
                } else{
                    listStepsPhoto.append(backgroundPhoto)
                }
                stepPhoto = nil
                InputStep = ""
            }) {
                Text("Save")
                    .foregroundColor(Color.theme.WhiteInstance)
                                    .font(.headline)
                                    .frame(width: 120, height: 40)
                                    .background(Color.theme.OrangeInstance)
                                    .cornerRadius(8)
            }
        }
}

//MARK: UPDATE STEP SHEET VIEW
struct UpdateStepsSheetView: View {
    @State private var newStep : String = ""
    @State private var newStepPhoto : PhotosPickerItem? = nil
    @Binding var Steps : [String]
    @Binding var listStepsPhoto : [PhotosPickerItem?]
    @Binding var updateStep : String
    @Binding var updatePhoto : PhotosPickerItem?
    @Binding var showingUpdateSheet : Bool
    var body: some View{
        VStack{
            InputFieldRecipe(text: $newStep , title: "Update Step", placeHolder: "Enter new step")
        }
        PhotosPicker(selection: $newStepPhoto, photoLibrary: .shared()) {
            Label("Select new a photo for step", systemImage: "photo.fill")
        }
        .padding(.vertical, 10)
        .foregroundColor(Color.theme.OrangeInstance)
            Button(action: {
                if(!newStep.isEmpty){
                    if let index = Steps.firstIndex(of: updateStep) {
                                        Steps[index] = newStep
                                        updateStep = ""
                                    }
                    if let index = listStepsPhoto.firstIndex(of: updatePhoto) {
                            if newStepPhoto != nil{
                                listStepsPhoto[index] = newStepPhoto!
                                updatePhoto = nil
                            }
                        showingUpdateSheet.toggle()
                                    }
                }
            }) {
                Text("Save")
                    .foregroundColor(Color.theme.WhiteInstance)
                                    .font(.headline)
                                    .frame(width: 120, height: 40)
                                    .background(Color.theme.OrangeInstance)
                                    .cornerRadius(8)
            }
        }
}

struct CreateStepsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStepsView(Steps: .constant([]), listStepsPhoto: .constant([]), backgroundPhoto: .constant(nil))
    }
}

private extension CreateStepsView{
    // MARK: STEPS UI
    var steps: some View{
        VStack(alignment: .leading) {
            if(Steps.isEmpty){
                HStack {
                    Circle().fill(Color.theme.OrangeInstance).frame(width: 10, height: 10)
                    Text("Click the plus button below to adding step")
                        .font(Font.custom.Content)
                        
                }.padding(.leading, 20)
            }
            ForEach(Array(Steps.enumerated()), id: \.element) { (index, step) in
                HStack{
                    Text("Step \(index + 1):") // Add the step number
                        .font(.custom("ZillaSlab-Regular", size: 22))
                    Spacer()
                    Button(action: {
                        if let photo = listStepsPhoto[index] ?? nil{
                               updateStepFunction(step: Steps[index], photo: photo)
                        }
                    }) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 15)
                    }
                    Button(action: {
                        // Delete the step at the current index
                        Steps.remove(at: index)
                        // Delete the corresponding step photo
                        listStepsPhoto.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 15)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                HStack {
                    Circle().fill(Color.theme.OrangeInstance).frame(width: 10, height: 10)
                    Text(step)
                        .font(Font.custom.Content)
                        .frame(width: 300, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            }
            Text("")
                .frame(height: 150)
        }
    }
}

