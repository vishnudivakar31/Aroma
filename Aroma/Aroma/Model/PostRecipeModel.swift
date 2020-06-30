//
//  PostRecipeModel.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/30/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

protocol PostRecipeProtocol {
    func recipePostedFailed(errorMessage: String)
    func recipePostedSuccessfully()
}

class PostRecipeModel {
    
    var delegate: PostRecipeProtocol?
    
    private var recipe: Recipe?
    private let storageRef = Storage.storage().reference().child("recipes")
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func postRecipe() {
        if let safeRecipe = recipe {
            if safeRecipe.name.count == 0 || safeRecipe.ingredients.count == 0 || safeRecipe.steps.count == 0 {
                delegate?.recipePostedFailed(errorMessage: "Name, ingredients and recipe are mandatory")
                return
            }
            Util.getUsername { (username) in
                self.recipe?.postedOn = Date().timeIntervalSince1970
                self.recipe?.postedBy = username
                if safeRecipe.imageData != nil {
                    self.uploadImage()
                } else {
                    self.saveRecipe()
                }
            }
        } else {
            delegate?.recipePostedFailed(errorMessage: "All fields are mandatory")
        }
    }
    
    private func uploadImage() {
        if let safeRecipe = recipe, let imageData = safeRecipe.imageData {
            let imageRef = storageRef.child("\(Date().timeIntervalSince1970).png")
            imageRef.putData(imageData, metadata: nil) { (metaData, error) in
                if error == nil {
                    imageRef.downloadURL { (url, error) in
                        if let safeError = error {
                            self.delegate?.recipePostedFailed(errorMessage: safeError.localizedDescription)
                        }
                        guard let downloadURL = url else {
                            return
                        }
                        self.recipe!.imageUrl = downloadURL.absoluteString
                        self.saveRecipe()
                    }
                } else {
                    if let safeError = error {
                        self.delegate?.recipePostedFailed(errorMessage: safeError.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func saveRecipe() {
        let db = Firestore.firestore()
        db.collection(Constants.FireBase.recipeCollectionName).addDocument(data: [
            Constants.RecipeModel.name: recipe!.name as String,
            Constants.RecipeModel.cookingTime: recipe!.cookingTime as Int,
            Constants.RecipeModel.ingredients: recipe!.ingredients as String,
            Constants.RecipeModel.steps: recipe!.steps as String,
            Constants.RecipeModel.imageUrl: (recipe!.imageUrl ?? "") as String,
            Constants.RecipeModel.likes: recipe!.likes as Int,
            Constants.RecipeModel.dislikes: recipe!.dislikes as Int,
            Constants.RecipeModel.postedOn: recipe!.postedOn as TimeInterval,
            Constants.RecipeModel.userId: (Auth.auth().currentUser?.uid ?? "") as String,
            Constants.RecipeModel.postedBy: (recipe!.postedBy ?? "") as String,
            Constants.RecipeModel.likedBy: recipe!.likedBy as [String],
            Constants.RecipeModel.dislikedBy: recipe!.dislikedBy as [String]
        ]) { (error) in
            if let safeError = error {
                self.delegate?.recipePostedFailed(errorMessage: safeError.localizedDescription)
            } else {
                self.delegate?.recipePostedSuccessfully()
            }
        }
    }
}
