//
//  SignUpController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

class SignUpModel {
    
    private let storageRef = Storage.storage().reference().child("images")
    
    
    func uploadImage(_ imageData: Data) {
        let uploadTast = storageRef.putData(imageData, metadata: nil) { (metaData, error) in
            if error != nil {
                print(self.storageRef.fullPath)
            }
        }
    }
}
