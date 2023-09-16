//
//  CreateStepsView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import PhotosUI

struct CreateStepsView: View {
    @Binding var Steps: [String]
    @Binding var listStepsPhoto: [PhotosPickerItem]
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var showingSheet = false
    @State private var InputStep = ""
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading) {
                    if(Steps.isEmpty){
                        HStack {
                            Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
                            Text("Click the plus button below to adding step")
                                .font(.custom("ZillaSlab-Regular", size: 20))
                                
                        }.padding(.leading, 20)
                    }
                    ForEach(Array(Steps.enumerated()), id: \.element) { (index, step) in
                        VStack{
                            Text("Step \(index + 1):") // Add the step number
                                .font(.custom("ZillaSlab-Regular", size: 22))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        HStack {
                            Circle().fill(Color.theme.Orange).frame(width: 10, height: 10)
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
        .sheet(isPresented: $showingSheet){
            AddStepsSheetView(InputStep: $InputStep, Steps: $Steps, stepPhoto: $stepPhoto, listStepsPhoto: $listStepsPhoto)
                .presentationDetents([.height(300)])
        }
        .frame(maxWidth: 500, maxHeight: .infinity, alignment: .topLeading)
        .overlay(
            Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color("Orange"))
                                .clipShape(Circle())
                                
            })
            .modifier(ButtonModifier()),
            alignment: .bottomTrailing
            
        )
        
    }
}

struct AddStepsSheetView: View {
    @Binding var InputStep : String
    @Binding var Steps : [String]
    @Binding var stepPhoto: PhotosPickerItem?
    @Binding var listStepsPhoto : [PhotosPickerItem]
    var body: some View{
        VStack{
            InputFieldRecipe(text: $InputStep , title: "Step", placeHolder: "Enter step")
        }
        
        PhotosPicker(selection: $stepPhoto, photoLibrary: .shared()) {
            Label("Select a photo for step", systemImage: "photo.fill")
        }.padding(.vertical, 10)
        
            Button(action: {
                if(!InputStep.isEmpty){
                    Steps.append(InputStep)
                    InputStep = ""
                }
                listStepsPhoto.append(stepPhoto!)
                stepPhoto = nil
            }) {
                Text("Save")
                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(width: 120, height: 40)
                                    .background(Color("Orange"))
                                    .cornerRadius(8)

            }
        }
}

struct CreateStepsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStepsView(Steps: .constant([]), listStepsPhoto: .constant([]))
    }
}
