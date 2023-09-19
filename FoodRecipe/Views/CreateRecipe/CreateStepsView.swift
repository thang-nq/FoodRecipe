//
//  CreateStepsView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import PhotosUI

struct CreateStepsView: View {
    //MARK: VARIABLES
    @Binding var Steps: [String]
    @Binding var listStepsPhoto: [PhotosPickerItem?]
    @Binding var backgroundPhoto: PhotosPickerItem?
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var showingSheet = false
    @State private var InputStep = ""
    
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
        }
        .frame(maxWidth: 500, maxHeight: .infinity, alignment: .topLeading)
        .overlay(
            //MARK: ADD STEPS BUTTON
            Button(action: {
                self.showingSheet.toggle()
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
                    listStepsPhoto.append(nil)
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
                        .font(.custom("ZillaSlab-Regular", size: 20))
                        
                }.padding(.leading, 20)
            }
            ForEach(Array(Steps.enumerated()), id: \.element) { (index, step) in
                HStack{
                    Text("Step \(index + 1):") // Add the step number
                        .font(.custom("ZillaSlab-Regular", size: 22))
                    Button(action: {
                        // Delete the step at the current index
                        Steps.remove(at: index)
                        // Delete the corresponding step photo
                        listStepsPhoto.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 20)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                HStack {
                    Circle().fill(Color.theme.OrangeInstance).frame(width: 10, height: 10)
                    Text(step)
                        .font(.custom("ZillaSlab-Regular", size: 20))
                        .frame(width: 280, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            }
        }
    }
}

