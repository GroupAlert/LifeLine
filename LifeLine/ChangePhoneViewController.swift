//
//  ChangePhoneViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/17/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ChangePhoneViewController: UIViewController {

    @IBOutlet weak var oldPhone: UILabel!
    @IBOutlet weak var newPhone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func updatePhone(_ sender: Any) {
        //LifeLineAPICaller().changePhone(oldPhone: <#T##String#>, newPhone: String, password: <#T##String#>, resultLabel: <#T##UILabel#>)
    }
    
}
