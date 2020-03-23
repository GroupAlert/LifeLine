//
//  AccountSettingsViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/16/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Alamofire

class AccountSettingsViewController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var dict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        self.name.text = (self.dict["name"] as! String)
        self.phone.text = (self.dict["phone"] as! String)
        
        let pictureUrl = URL(string: dict["picture"] as! String)!

        Alamofire.request(pictureUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                    if let data = response.data {
                        self.picture.image = UIImage(data: data)
                    }
                }
            }
    }
    
    @IBAction func defaultPicture(_ sender: Any) {
        LifeLineAPICaller().deletePicture(phone: (self.dict["phone"] as! String), resultLabel: self.result)
    }
    
    @IBAction func updatePicture(_ sender: Any) {
        let image = self.picture.image!
        LifeLineAPICaller().changePicture(phone: (self.dict["phone"] as! String), image: image.pngData(), resultLabel: self.result)
    }
    
    @IBAction func updateName(_ sender: Any) {
        LifeLineAPICaller().changeName(phone: self.phone.text!, name: self.name.text!, resultLabel: self.result)
    }
    
    @IBAction func signOut(_ sender: Any) {
        let dict:[String:String] = ["loggedin":"no"]
        if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
            print("Unable to save userinfo")
        }
        self.performSegue(withIdentifier: "SignOutSegue", sender: self)
    }
    
}
