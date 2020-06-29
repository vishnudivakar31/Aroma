//
//  LoginModel.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

protocol LoginModelProtocol {
    func userLoginSuccessfull(email: String, password: String)
    func userLoginFailed(error: String)
    func resetPasswordSuccessfull()
    func resetPasswordFailed(error: String)
}

class LoginModel {
    
    var delegate: LoginModelProtocol?
    
    func loginUser(email: String, password: String) {
        if email.count > 0 && password.count > 0 {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    self.delegate?.userLoginSuccessfull(email: email, password: password)
                } else {
                    self.delegate?.userLoginFailed(error: error!.localizedDescription)
                }
            }
        } else {
            self.delegate?.userLoginFailed(error: "Email and password are mandatory")
        }
    }
    
    func forgotPassword(email: String) {
        if email.count > 0 {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    self.delegate?.resetPasswordSuccessfull()
                } else {
                    self.delegate?.resetPasswordFailed(error: error!.localizedDescription)
                }
            }
        } else {
            self.delegate?.resetPasswordFailed(error: "Email is a mandatory field")
        }
    }
}
