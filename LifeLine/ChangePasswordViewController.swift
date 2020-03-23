//
//  ChangePasswordViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/17/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPassword2: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func updatePassword(_ sender: Any) {
        //LifeLineAPICaller().changePassword(phone: <#T##String#>, oldPassword: <#T##String#>, newPassword: <#T##String#>, resultLabel: <#T##UILabel#>)
    }
    
}
