//
//  UserModel.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation

struct UserModel {
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
    var imageData: Data?
    var imageUrl: String?
    var joinedDate = Date().timeIntervalSince1970
}
