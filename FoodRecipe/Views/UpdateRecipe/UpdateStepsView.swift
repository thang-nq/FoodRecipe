//
//  UpdateStepsView.swift
//  FoodRecipe
//
//  Created by Tien on 19/09/2023.
//

import SwiftUI
import PhotosUI

struct UpdateStepsView: View {
    @StateObject var detailVM = RecipeDetailViewModel()
    @StateObject var updateVM = UpdateRecipeViewModel()
    //MARK: VARIABLES
    @State var recipeId: String
    @Binding var Steps: [String]
    @Binding var listStepsPhoto: [PhotosPickerItem?]
    @Binding var backgroundPhoto: PhotosPickerItem?
    @Binding var listStepId : [String]
    @State private var stepId : String = ""
    @State private var updateStep = ""
    @State private var updatePhoto : PhotosPickerItem? = nil
    @State private var stepPhoto: PhotosPickerItem? = nil
    @State private var showingSheet = false
    @State private var InputStep = ""
    @State private var showingUpdateSheet = false
    
    //Get step id function
    func getStepId(updateStep: String) async {
        var cookingStep: CookingStep?
        Task {
            if let recipe = detailVM.recipe {
                if let cookingStep = recipe.steps.first(where: { $0.context == updateStep }) {
                    stepId = cookingStep.id!
                }
            }
        }
    }
    //Update step function
    private func updateStepFunction(step: String) {
        updateStep = step
        showingUpdateSheet.toggle()
    }
    //Delete step function
    private func deletStepFunction(recipeId: String, stepId: String) async{
        Task{
            await detailVM.deleteCookingStep(recipeID: recipeId, stepID: stepId)
        }
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
            AddingStepsSheetView(recipeId: $recipeId,InputStep: $InputStep, Steps: $Steps, stepPhoto: $stepPhoto, listStepsPhoto: $listStepsPhoto, backgroundPhoto: $backgroundPhoto)
                .presentationDetents([.height(300)])
        }
        .sheet(isPresented: $showingUpdateSheet){
            // MARK: UPDATE STEP SHEET UI
            UpdatingStepsSheetView(listStepId: $listStepId, stepId: $stepId, recipeId: $recipeId, Steps: $Steps, listStepsPhoto: $listStepsPhoto,updateStep: $updateStep, updatePhoto: $updatePhoto, showingUpdateSheet: $showingUpdateSheet)
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

struct UpdateStepsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStepsView(Steps: .constant([]), listStepsPhoto: .constant([]), backgroundPhoto: .constant(nil))
    }
}
//MARK: UPDATE STEP SHEET VIEW
struct UpdatingStepsSheetView: View {
    @StateObject var detailVM = RecipeDetailViewModel()
    @Binding var listStepId : [String]
    @Binding var stepId : String
    @State private var newStep : String = ""
    @State private var newStepPhoto : PhotosPickerItem? = nil
    @Binding var recipeId : String
    @Binding var Steps : [String]
    @Binding var listStepsPhoto : [PhotosPickerItem?]
    @Binding var updateStep : String
    @Binding var updatePhoto : PhotosPickerItem?
    @Binding var showingUpdateSheet : Bool
    func getStepId(updateStep: String) async {
        var cookingStep: CookingStep?
        Task {
            if let recipe = detailVM.recipe {
                if let cookingStep = recipe.steps.first(where: { $0.context == updateStep }) {
                    stepId = cookingStep.id!
                }
            }
        }
    }
    func updateStepDisplay(index: Int) async{
        Steps[index] = newStep
        updateStep = ""
        newStep = ""
    }
    
    var body: some View{
        VStack{
            InputFieldRecipe(text: $newStep , title: "Update Step", placeHolder: "Enter new step")
        }
        .onAppear(){
            Task(priority: .medium) {
                do {
                    try await detailVM.getRecipeDetail(recipeID: recipeId)
                    await getStepId(updateStep: updateStep)
                } catch {
                    // Handle any errors that occur during the async operation
                    print("Error: \(error)")
                }
            }
        }
        PhotosPicker(selection: $newStepPhoto, photoLibrary: .shared()) {
            Label("Select new a photo for step", systemImage: "photo.fill")
        }
        .padding(.vertical, 10)
        .foregroundColor(Color.theme.OrangeInstance)
            Button(action: {
                if(!newStep.isEmpty){
                    if( newStepPhoto == nil){
                        if let index = Steps.firstIndex(of: updateStep){
                            Task(){
                                await detailVM.updateCookingStep(recipeID: recipeId, stepID: stepId, context: newStep, backgroundImage: nil)
                                await updateStepDisplay(index: index)
                            }
                        }
                    }else{
                        if let index = Steps.firstIndex(of: updateStep){
                            Task{
                                await detailVM.updateCookingStep(recipeID: recipeId, stepID: stepId, context: newStep, backgroundImage: newStepPhoto!)
                                await updateStepDisplay(index: index)
                            }
                        }
                    }
                    showingUpdateSheet.toggle()
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
//MARK: ADD STEP SHEET VIEW
struct AddingStepsSheetView: View {
    @StateObject var detailVM = RecipeDetailViewModel()
    @StateObject var updateVM = UpdateRecipeViewModel()
    @Binding var recipeId : String
    @Binding var InputStep : String
    @Binding var Steps : [String]
    @Binding var stepPhoto: PhotosPickerItem?
    @Binding var listStepsPhoto : [PhotosPickerItem?]
    @Binding var backgroundPhoto: PhotosPickerItem?
    func resetField() async{
        stepPhoto = nil
        InputStep = ""
    }
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
                Task{
                    await detailVM.addCookingStep(recipeID: recipeId, context: InputStep, backgroundImage: backgroundPhoto, stepNumber: Steps.count + 1)
                    await resetField()
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

private extension UpdateStepsView{
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
                    Spacer()
                    Button(action: {
                        updateStepFunction(step: Steps[index])
                    }) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.OrangeInstance)
                            .padding(.trailing, 15)
                    }
                    Button(action: {
                        stepId = listStepId[index]
                        Task{
                            await deletStepFunction(recipeId: recipeId ,stepId: stepId)
                        }
                        Steps.remove(at: index)

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
                        .font(.custom("ZillaSlab-Regular", size: 20))
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
