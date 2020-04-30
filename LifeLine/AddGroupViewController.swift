//
//  AddGroupViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse

class AddGroupViewController: UIViewController {
    
  
    @IBOutlet weak var GroupNameField: UITextField!
    var dict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }

    
    @IBAction func CreateGroupButton(_ sender: Any) {
    
            let name = GroupNameField.text!
            let userinfo = Archiver().getObject(fileName: "userinfo") as! NSDictionary
            let phone = userinfo["phone"]

            if (name == nil ){
                print("needs to not be empty")

            }else{
                LifeLineAPICaller().createGroup(groupName: name, phone: phone as! String)
            }
        }
    
}
