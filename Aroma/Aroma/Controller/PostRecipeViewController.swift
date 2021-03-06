//
//  PostRecipeViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/30/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit

class PostRecipeViewController: UIViewController {

    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var cookingTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var receipeTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    private var imagePicker = UIImagePickerController()
    private var loadingAlert = UIAlertController(title: "Post Recipe", message: "Loading", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        ingredientsTextView.delegate = self
        receipeTextView.delegate = self
    }
    
    
    func designPage() {
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 5
        
        nameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Sandwich",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        cookingTimeTextField.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        cookingTimeTextField.layer.borderWidth = 1.0
        cookingTimeTextField.layer.cornerRadius = 10
        cookingTimeTextField.attributedPlaceholder = NSAttributedString(string: "5 Minutes",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        ingredientsTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        ingredientsTextView.layer.borderWidth = 1.0
        ingredientsTextView.layer.cornerRadius = 10
        ingredientsTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ingredientsTextView.text = "1. Bread\n2. Burger\n3. Cheese"
        ingredientsTextView.textColor = UIColor.darkGray
        
        receipeTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        receipeTextView.layer.borderWidth = 1.0
        receipeTextView.layer.cornerRadius = 10
        receipeTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        receipeTextView.text = "1. Fry the burger\n2. Place the burger in between of bread\n3. Enjoy"
        receipeTextView.textColor = UIColor.darkGray
        
        recipePicture.layer.borderWidth = 5
        recipePicture.layer.masksToBounds = false
        recipePicture.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        recipePicture.layer.cornerRadius = recipePicture.frame.height / 2
        recipePicture.clipsToBounds = true
        
        saveButton.layer.cornerRadius = 20
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

    @IBAction func saveButtonPressed(_ sender: Any) {
        let recipe = Recipe(
            name: nameTextField.text!,
            cookingTime: Int(cookingTimeTextField.text ?? "0") ?? 0,
            ingredients: ingredientsTextView.text!,
            steps: receipeTextView.text!,
            imageData: recipePicture.image?.pngData(),
            likes: 0,
            dislikes: 0,
            postedOn: Date.timeIntervalSinceReferenceDate,
            likedBy: [""],
            dislikedBy: [""])
        let postRecipeModel = PostRecipeModel(recipe: recipe)
        postRecipeModel.delegate = self
        present(loadingAlert, animated: true, completion: nil)
        postRecipeModel.postRecipe()
    }
}

// MARK:- UITextViewDelegate
extension PostRecipeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        textView.frame = frame
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            if textView.tag == 0 {
                ingredientsTextView.text = "1. Bread\n2. Burger\n3. Cheese"
                ingredientsTextView.textColor = UIColor.darkGray
            } else if textView.tag == 1 {
                receipeTextView.text = "1. Fry the burger\n2. Place the burger in between of bread\n3. Enjoy"
                receipeTextView.textColor = UIColor.darkGray
            }
        }
    }
}

// MARK:- UIImagePickerDelegate
extension PostRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            fatalError("unable to fetch image")
        }
        recipePicture.image = image
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- PostRecipeProtocol
extension PostRecipeViewController: PostRecipeProtocol {
    func recipePostedFailed(errorMessage: String) {
        loadingAlert.dismiss(animated: true, completion: nil)
        let alertController = UIAlertController(title: "Warning", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func recipePostedSuccessfully() {
        loadingAlert.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
