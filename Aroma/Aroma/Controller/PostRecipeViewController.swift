//
//  PostRecipeViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/30/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit

class PostRecipeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var recipePicture: UIImageView!
    @IBOutlet weak var cookingTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var receipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        ingredientsTextView.delegate = self
        receipeTextView.delegate = self
    }
    
    
    func designPage() {
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
        
    }
    
    @IBAction func uploadPicturePressed(_ sender: UIButton) {
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
    }
}
