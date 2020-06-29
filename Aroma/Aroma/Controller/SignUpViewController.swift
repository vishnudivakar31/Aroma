//
//  SignUpViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/28/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func designPage() {
        self.navigationController?.navigationBar.isHidden = true
        signUpView.layer.cornerRadius = 40
        nameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 10
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        confirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        confirmPasswordTextField.layer.borderWidth = 1.0
        confirmPasswordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        profilePicture.layer.borderWidth = 5
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.clipsToBounds = true
        signUpButton.layer.cornerRadius = 20
    }

    @IBAction func uploadPicturePressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Upload profile picture", message: "Choose a media.", preferredStyle: .alert)
        let galleryAction = UIAlertAction(title: "Photos", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        var userModel = UserModel(userId: "", name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        if let data = profilePicture.image?.pngData() {
            userModel.imageData = data
            let signUpModel = SignUpModel(userModel: userModel)
            signUpModel.delegate = self
            activityIndicator.isHidden = false
            signUpModel.signUpUser()
        }
    }
}

// MARK:- UIImagePicker Delegates
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            fatalError("unable to fetch image")
        }
        profilePicture.image = image
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- SignUpProtocols

extension SignUpViewController: SignUpProtocol {
    func userRegistrationSuccessfull() {
        if Auth.auth().currentUser != nil {
            activityIndicator.isHidden = true
            performSegue(withIdentifier: Constants.HomePage.segueIdentifier, sender: self)
        }
    }
    
    func signUpErrorOccured(errorMessage: String) {
        let alertController = UIAlertController(title: "Warning", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        activityIndicator.isHidden = true
        present(alertController, animated: true, completion: nil)
    }
    
    
}
