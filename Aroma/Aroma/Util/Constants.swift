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
    }
    struct UserModel {
        static let name = "name"
        static let email = "email"
        static let profilePictureUrl = "image-url"
        static let joinedDate = "joined-date"
    }
    struct HomePage {
        static let segueIdentifier = "goToHomePage"
    }
    struct Aroma {
        static let emailIdentifier = "email"
        static let passwordIdentifier = "password"
        static let biometricReason = "FaceID Authentication" 
    }
}
