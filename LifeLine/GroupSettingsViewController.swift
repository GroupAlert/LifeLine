//
//  GroupSettingsViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 5/1/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Alamofire

class GroupSettingsViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var groupNameField: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    
    var group = [String:Any]()
    var isOwner = Bool()
    var phone = String()
    var groupID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        let pictureUrl = URL(string: group["picture"] as! String)!
        Alamofire.request(pictureUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    self.photo.image = UIImage(data: data)
                    self.photo.setRounded()
                }
            }
        }
        groupNameField.text = group["group_name"] as? String
        let userDict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        phone = userDict["phone"] as! String
        groupID = group["group_id"] as! String
    }
    
    @IBAction func deleteGroup(_ sender: UIButton) {
        if isOwner {
            LifeLineAPICaller().deleteGroup(phone: phone, groupId:groupID, resultLabel:ResultLabel)
        }
        else{
            LifeLineAPICaller().leaveGroup(phone: phone, groupId:groupID, resultLabel:ResultLabel)
        }
    }
    
    @IBAction func photoButton(_ sender: Any) {
        let image = self.photo.image!
        LifeLineAPICaller().changeGroupPicture(groupID: groupID, image: image.pngData(), resultLabel: ResultLabel)
    }
    
    @IBAction func UpdateName(_ sender: UIButton) {
        LifeLineAPICaller().changeGroupName(groupID: groupID, owner: phone, name: groupNameField.text!, resultLabel: ResultLabel)
    }
}
