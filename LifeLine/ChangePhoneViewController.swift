//
//  ChangePhoneViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/17/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ChangePhoneViewController: UIViewController {

    @IBOutlet weak var oldPhoneLabel: UILabel!
    @IBOutlet weak var newPhoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        oldPhoneLabel.text = (dict["phone"] as! String)
    }

    @IBAction func updatePhone(_ sender: Any) {
        let oldphone = oldPhoneLabel.text!
        let newPhone = newPhoneField.text!
        let password = passwordField.text!
        LifeLineAPICaller().changePhone(oldPhone: oldphone, newPhone: newPhone, password: password, resultLabel: resultLabel)
    }
}
