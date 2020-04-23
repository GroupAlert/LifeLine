//
//  LoginViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/8/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse

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
            let phone = dict["phone"] as! String
            LifeLineAPICaller().signin(phone: phone, password: dict["password"] as! String, resultLabel: resultLabel)
            if resultLabel.text != "success" {
                return
            }
            let currentUser = PFUser.current()
            if currentUser == nil {
                PFUser.logInWithUsername(inBackground: phone, password: phone) { (user, error) in
                    if user == nil {
                        let user = PFUser()
                        user.username = phone
                        user.password = phone
                        user.signUpInBackground { (success, error) in
                            //UIViewController.removeSpinner(spinner: sv)
                            if success{
                                print("Created PFUser")
                            }else{
                                if let descrip = error?.localizedDescription{
                                    print(descrip)
                                }
                            }
                        }
                    }
                }
            }
            self.performSegue(withIdentifier: "SignInSegue", sender: self)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if resultLabel.text == "success" {
            let phone = self.phoneField.text!
            let currentUser = PFUser.current()
            if currentUser == nil {
                PFUser.logInWithUsername(inBackground: phone, password: phone) { (user, error) in
                    if user == nil {
                        let user = PFUser()
                        user.username = phone
                        user.password = phone
                        user.signUpInBackground { (success, error) in
                            //UIViewController.removeSpinner(spinner: sv)
                            if success{
                                print("Created PFUser")
                            }else{
                                if let descrip = error?.localizedDescription{
                                    print(descrip)
                                }
                            }
                        }
                    }
                }
            }
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
