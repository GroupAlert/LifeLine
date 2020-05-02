//
//  AccountSettingsViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/16/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Parse

class AccountSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        self.view.addSubview(UIView().customActivityIndicator(view: self.view, backgroundColor: UIColor.green))
        Alamofire.request(pictureUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    self.picture.image = UIImage(data: data)
                }
            }
        }
        self.view.subviews.last?.removeFromSuperview()
    }
    
    @IBAction func defaultPicture(_ sender: Any) {
        LifeLineAPICaller().deletePicture(phone: (self.dict["phone"] as! String), resultLabel: self.result)
    }
    
    @IBAction func updatePicture(_ sender: Any) {
        let image = self.picture.image!
        LifeLineAPICaller().changePicture(phone: (self.dict["phone"] as! String), image: image.pngData(), resultLabel: self.result)
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker,animated: true, completion: nil )
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        picture.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateName(_ sender: Any) {
        LifeLineAPICaller().changeName(phone: self.phone.text!, name: self.name.text!, resultLabel: self.result)
    }
    
    @IBAction func signOut(_ sender: Any) {
        //let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logOutInBackground { (error: Error?) in
            //UIViewController.removeSpinner(spinner: sv)
            if (error != nil) {
                if let descrip = error?.localizedDescription{
                    print(descrip)
                }else{
                    print("error logging out of chat")
                }
            }
        }
        let dict:[String:String] = ["loggedin":"no"]
        if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
            print("Unable to save userinfo")
        }
        self.performSegue(withIdentifier: "SignOutSegue", sender: self)
    }
    
}
