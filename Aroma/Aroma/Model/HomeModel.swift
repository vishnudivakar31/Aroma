//
//  HomeModel.swift
//  Aroma
//
//  Created by Vishnu Divakar on 7/1/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

protocol HomeModelProtocol {
    func recipeListUpdated(recipeList: [Recipe])
    func homeModelErrorRaised(errorMessage: String)
}

class HomeModel {
    var delegate: HomeModelProtocol?
    var recipeList = [Recipe]()
    var listener: ListenerRegistration?
    
    
    private let db = Firestore.firestore().collection(Constants.FireBase.recipeCollectionName)
    
    private func convertDocumentToRecipe(_ document: [String: Any], id: String) -> Recipe {
        let recipe = Recipe(
            name: document[Constants.RecipeModel.name] as! String,
            cookingTime: document[Constants.RecipeModel.cookingTime] as! Int,
            ingredients: document[Constants.RecipeModel.ingredients] as! String,
            steps: document[Constants.RecipeModel.steps] as! String,
            imageUrl: document[Constants.RecipeModel.imageUrl] as? String,
            likes: document[Constants.RecipeModel.likes] as! Int,
            dislikes: document[Constants.RecipeModel.dislikes] as! Int,
            postedOn: document[Constants.RecipeModel.postedOn] as! TimeInterval,
            userId: document[Constants.RecipeModel.userId] as? String,
            postedBy: document[Constants.RecipeModel.postedBy] as? String,
            likedBy: document[Constants.RecipeModel.likedBy] as! [String],
            dislikedBy: document[Constants.RecipeModel.dislikedBy] as! [String],
            documentID: id)
        return recipe
    }
    
    
    func addSnapshotListener() {
        listener = db.addSnapshotListener { (snapShot, error) in
            if error == nil {
                for documentChange in snapShot!.documentChanges {
                    switch documentChange.type {
                    case .added:
                        let recipe = self.convertDocumentToRecipe(documentChange.document.data(), id: documentChange.document.documentID)
                        self.recipeList.insert(recipe, at: 0)
                    case .modified:
                        let recipe = self.convertDocumentToRecipe(documentChange.document.data(), id: documentChange.document.documentID)
                        self.recipeList.insert(recipe, at: Int(documentChange.oldIndex))
                    case .removed:
                        self.recipeList.remove(at: Int(documentChange.oldIndex))
                    }
                }
                self.delegate?.recipeListUpdated(recipeList: self.recipeList)
            }
        }
    }
}
