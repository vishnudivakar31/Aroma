//
//  SignUpController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

protocol SignUpProtocol {
    func userRegistrationSuccessfull()
    func signUpErrorOccured(errorMessage: String)
}

class SignUpModel {
    
    private var userModel: UserModel
    private let storageRef = Storage.storage().reference().child("images")
    var delegate: SignUpProtocol?
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    private func uploadImage() {
        if let imageData = userModel.imageData {
            let imageRef = storageRef.child("\(Date().timeIntervalSince1970).png")
            imageRef.putData(imageData, metadata: nil) { (metaData, error) in
                if error == nil {
                    imageRef.downloadURL { (url, error) in
                        if let safeError = error {
                            self.delegate?.signUpErrorOccured(errorMessage: safeError.localizedDescription)
                        }
                        guard let downloadURL = url else {
                            return
                        }
                        self.userModel.imageUrl = downloadURL.absoluteString
                        self.saveUserModel()
                    }
                } else {
                    if let safeError = error {
                        self.delegate?.signUpErrorOccured(errorMessage: safeError.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func saveUserModel() {
        let db = Firestore.firestore()
        db.collection(Constants.FireBase.userModelCollectionName).addDocument(data: [
            Constants.UserModel.name: userModel.name,
            Constants.UserModel.email: userModel.email,
            Constants.UserModel.profilePictureUrl: userModel.imageUrl ?? "",
            Constants.UserModel.joinedDate: userModel.joinedDate,
            Constants.UserModel.userId: userModel.userId
        ]) { (error) in
            if let safeError = error {
                self.delegate?.signUpErrorOccured(errorMessage: safeError.localizedDescription)
            } else {
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.userModel.email, forKey: Constants.Aroma.emailIdentifier)
                userDefaults.set(self.userModel.password, forKey: Constants.Aroma.passwordIdentifier)
                self.delegate?.userRegistrationSuccessfull()
            }
        }
    }
    
    func signUpUser() {
        if userModel.password == userModel.confirmPassword && userModel.email.count > 0 && userModel.name.count > 0 {
            Auth.auth().createUser(withEmail: userModel.email, password: userModel.password) { (result, error) in
                if let safeError = error {
                    self.delegate?.signUpErrorOccured(errorMessage: safeError.localizedDescription)
                }
                if let userId = Auth.auth().currentUser?.uid {
                    self.userModel.userId =  userId
                }
                self.uploadImage()
            }
        } else {
            self.delegate?.signUpErrorOccured(errorMessage: "Name, Email and Password are mandatory fields. Password should match.")
        }
    }
}
