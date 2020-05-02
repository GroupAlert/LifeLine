//
//  GroupSettingsViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 5/1/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class GroupSettingsViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var groupNameFiels: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    var groupID = String()
    var userType = String()
    var phone = String()
    var dict = [String:Any]()
    let userDict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone = userDict["phone"] as! String
        let url = URL(string: LifeLineAPICaller().baseURL + "group/groupget.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let postString = "group_id=\(self.groupID)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.dict = dataDictionary
            }
        }
        task.resume()
        print(dict)
    }
    @IBAction func deleteGroup(_ sender: UIButton) {
        let adminPhone = dict["admin"] as! String
        if ( self.phone == adminPhone){
            
            LifeLineAPICaller().deleteGroup(groupID: self.groupID, phone: self.phone, resultLabel: self.ResultLabel)
        }
        else{
            LifeLineAPICaller().leaveGroup(groupID: self.groupID, phone: self.phone, resultLabel: self.ResultLabel)
        }
    }
    
    @IBAction func photoButton(_ sender: Any) {
        let image = self.photo.image!
        LifeLineAPICaller().changeGroupPicture(groupID: self.groupID, image: image.pngData(), resultLabel: self.ResultLabel)
    }
    
    @IBAction func UpdateName(_ sender: UIButton) {
        LifeLineAPICaller().changeGroupName(groupID: self.groupID, owner: self.phone, name: self.groupNameFiels.text!, resultLabel: self.ResultLabel)
    }
}
