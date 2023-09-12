//
//  HomeViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//


import FirebaseFirestore
import FirebaseFirestoreSwift


//@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var recipes : [Recipe] = []
    private var db = Firestore.firestore()
    
    func getRecipeList() {
        print(recipes)
        db.collection("recipes").getDocuments { snapshot, error in
            if error == nil {
                
                if let snapshot = snapshot {
                    self.recipes = snapshot.documents.map { d in
                        return Recipe(id: d.documentID,
                                      name: d["name"] as? String ?? "",
                                      creatorUID: d["creatorUID"] as? String ?? "",
                                      backgroundURL: d["backgroundURL"] as? String ?? "",
                                      steps: d["steps"] as? String ?? "")
                    }
                } else {
                    
                }
                
            }
            else {
                print("DEBUG: \(error!.localizedDescription)")
            }
        }
    }

    
}
