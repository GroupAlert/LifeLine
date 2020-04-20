//
//  LifeLineAPICaller.swift
//  LifeLine
//
//  Created by Praveen V on 3/8/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LifeLineAPICaller {
    
    let baseURL = "http://ec2-54-241-187-187.us-west-1.compute.amazonaws.com/lifeline/"
    
    func signin(phone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personlogin.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func signup(phone:String, name:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(name)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func changePicture(phone:String, image: Data?, resultLabel:UILabel) {
        let url = baseURL + "person/personpictureupload.php"

        let parameters = ["phone": phone]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
                multipartFormData.append(image!, withName: "fileToUpload", fileName: "poop.png", mimeType: "image/png")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let dataDictionary = response.result.value as? [String: Any] {
                            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
    func changeName(phone:String, name:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetname.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func deletePicture(phone:String, resultLabel:UILabel) {
        let url = baseURL + "person/personpicturedelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            self.setUserInfo(number: phone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func changePhone(oldPhone:String, newPhone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetphone.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "old_phone=\(oldPhone)&new_phone=\(newPhone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            self.setUserInfo(number: newPhone, dict: dataDictionary, label: resultLabel)
        }
        task.resume()
    }
    
    func setUserInfo(number:String, dict:[String : Any], label:UILabel) {
        DispatchQueue.main.async {
            let result = dict["result"] as? String
            label.text = result
            if (result == "success") {
                let name = dict["name"] as! String
                let picture = dict["picture"] as! String
                
                let dict:[String:String] = ["loggedin":"yes", "phone":number, "name":name, "picture":picture]
                if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
                    print("Unable to save userinfo")
                }
            }
        }
    }
    
    func changePassword(phone:String, oldPassword:String, newPassword:String, resultLabel:UILabel) {
        let url = baseURL + "person/personsetpassword.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&old_pass=\(oldPassword)&new_pass=\(newPassword)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    
    func deleteAccount(phone:String, password:String, resultLabel:UILabel) {
        let url = baseURL + "person/persondelete.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
                if (result == "success") {
                    
                    let dict:[String:String] = ["loggedin":"no"]
                    if (!Archiver().saveObject(fileName: "userinfo", object: dict)) {
                        print("Unable to save userinfo")
                    }
                }
            }
        }
        task.resume()
    }
    
    func forgetPassword(phone:String, resultLabel:UILabel) {
        let url = baseURL + "person/personforgotpassword.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            DispatchQueue.main.async {
                let result = dataDictionary["result"] as? String
                resultLabel.text = result
            }
        }
        task.resume()
    }
    //Fix this
    func getGroups(phone:String, name:String, password:String, password2:String, resultLabel:UILabel) {
        let url = baseURL + "person/personinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            DispatchQueue.main.async {
                resultLabel.text = responseString as String
            }
        }
        task.resume()
    }
    //Fix this
    func getGroupMembers(phone:String, name:String, password:String, password2:String, resultLabel:UILabel) {
        let url = baseURL + "person/personinsert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&acc_pass=\(password)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            DispatchQueue.main.async {
                resultLabel.text = responseString as String
            }
        }
        task.resume()
    }
    //Test this with phone: 234, password: 234
    func getAccidentAlert(phone:String, name:String, location:String, time:String) {
        let url = baseURL + "group/groupaccidentalert.php"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)&name=\(name)&location=\(name)&time=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            let result = dataDictionary["result"] as! String
            print(result)
        }
        task.resume()
    }
    
}
