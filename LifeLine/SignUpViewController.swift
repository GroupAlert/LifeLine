//
//  SignUpViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/9/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if resultLabel.text == "User created" {
            UserDefaults.standard.set(phoneField.text, forKey: "Phone")
            UserDefaults.standard.set(nameField.text, forKey: "Name")
            phoneField.text?.removeAll()
            nameField.text?.removeAll()
            passwordField.text?.removeAll()
            password2Field.text?.removeAll()
            resultLabel.text = ""
            self.performSegue(withIdentifier: "SignUpSegue", sender: self)
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let phone = phoneField.text!
        let name = nameField.text!
        let password = passwordField.text!
        let password2 = password2Field.text!
        if (password != password2) {
            resultLabel.text = "Passwords do not match"
            passwordField.text?.removeAll()
            password2Field.text?.removeAll()
            return
        }
        LifeLineAPICaller().signup(phone: phone, name: name, password: password, resultLabel: resultLabel)
    }

}
