//
//  Constants.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation

struct Constants {
    struct FireBase {
        static let userModelCollectionName = "user"
        static let recipeCollectionName = "recipe"
    }
    struct UserModel {
        static let name = "name"
        static let email = "email"
        static let profilePictureUrl = "image-url"
        static let joinedDate = "joined-date"
        static let userId = "user-id"
    }
    struct HomePage {
        static let segueIdentifier = "goToHomePage"
        static let cellIdentifier = "homeCellIdentifier"
    }
    struct Aroma {
        static let emailIdentifier = "email"
        static let passwordIdentifier = "password"
        static let biometricReason = "FaceID Authentication"
    }
    struct PostReceipe {
        static let segueIdentifier = "goToPostReceipe"
    }
    struct RecipeModel {
        static let name =  "name"
        static let cookingTime = "cookingTime"
        static let ingredients = "ingredients"
        static let steps = "steps"
        static let imageUrl = "imageUrl"
        static let likes = "likes"
        static let dislikes = "dislikes"
        static let postedOn = "postedOn"
        static let userId = "userId"
        static let postedBy = "postedBy"
        static let likedBy = "likedBy"
        static let dislikedBy = "dislikedBy"
    }
}
