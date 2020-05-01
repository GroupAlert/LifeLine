//
//  GroupMemberViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/23/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class GroupMemberViewController: UIViewController {

    var group = String()
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var roleField: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var roles: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setRole(_ sender: Any) {
        let user = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let adminStr = user["phone"] as! String
        let phoneStr = phone.text!
        let role = roleField.text!
        LifeLineAPICaller().changeRole(groupID: group, admin: adminStr, member: phoneStr, role: role, resultLabel: result)
    }
    
    @IBAction func removeUser(_ sender: Any) {
        let user = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let adminStr = user["phone"] as! String
        let phoneStr = phone.text!
        LifeLineAPICaller().deleteMember(groupID: group, admin: adminStr, member: phoneStr, resultLabel: result)
    }
    
}
