//
//  ViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/27/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var loginModel = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        loginModel.delegate = self
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkForFaceId()
    }
    
    func checkForFaceId() {
        let userDefaults = UserDefaults.standard
        if let email = userDefaults.string(forKey: Constants.Aroma.emailIdentifier), let password = userDefaults.string(forKey: Constants.Aroma.passwordIdentifier) {
            guard #available(iOS 8.0, *) else {
                return print("Not supported")
            }
            
            let context = LAContext()
            var error: NSError?
            
            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                return print(error!)
            }
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: Constants.Aroma.biometricReason) { isAuthorized, error in
                if isAuthorized {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = false
                    }
                    self.loginModel.loginUser(email: email, password: password)
                }
            }
        }
    }
    
    func designPage() {
        loginView.layer.cornerRadius = 10
        emailTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        emailTextView.layer.borderWidth = 1.0
        emailTextView.layer.cornerRadius = 10
        emailTextView.attributedPlaceholder = NSAttributedString(string: "email",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        passwordTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        passwordTextView.layer.borderWidth = 1.0
        passwordTextView.layer.cornerRadius = 10
        passwordTextView.attributedPlaceholder = NSAttributedString(string: "password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        loginButton.layer.cornerRadius = 20
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        loginModel.loginUser(email: emailTextView.text!, password: passwordTextView.text!)
    }
    
    @IBAction func forgotButtonPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        loginModel.forgotPassword(email: emailTextView.text!)
    }
}

// MARK:- LoginModelProtocol Implementation
extension LoginController: LoginModelProtocol {
    func resetPasswordSuccessfull() {
        activityIndicator.isHidden = true
        let alertController = UIAlertController(title: "Successfull", message: "Password reset email has been generated", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func resetPasswordFailed(error: String) {
        activityIndicator.isHidden = true
        let alertController = UIAlertController(title: "Warning", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func userLoginSuccessfull(email: String, password: String) {
        activityIndicator.isHidden = true
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: Constants.Aroma.emailIdentifier)
        userDefaults.set(password, forKey: Constants.Aroma.passwordIdentifier)
        performSegue(withIdentifier: Constants.HomePage.segueIdentifier, sender: self)
    }
    
    func userLoginFailed(error: String) {
        activityIndicator.isHidden = true
        let alertController = UIAlertController(title: "Warning", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

