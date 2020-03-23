//
//  DeleteAccountViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/20/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var acknowledge: UISwitch!
    @IBOutlet var result: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func deleteAccount(_ sender: Any) {
    }
    
}
