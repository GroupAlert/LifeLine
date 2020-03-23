//
//  LoginViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/8/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let loggedin = dict["loggedin"] as! String
        if (loggedin == "yes") {
            self.performSegue(withIdentifier: "SignInSegue", sender: self)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if resultLabel.text == "success" {
            phoneField.text?.removeAll()
            resultLabel.text = ""
            self.performSegue(withIdentifier: "SignInSegue", sender: self)
        }
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        let phone = self.phoneField.text!
        let password = self.passwordField.text!
        passwordField.text?.removeAll()
        LifeLineAPICaller().signin(phone: phone, password: password, resultLabel: resultLabel)
    }
    
}
