//
//  ViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/27/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
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


}

