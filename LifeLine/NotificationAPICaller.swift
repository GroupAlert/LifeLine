////
////  NotificationAPICaller.swift
////  LifeLine
////
////  Created by Mark Falcone on 4/21/20.
////  Copyright © 2020 Praveen Vandeyar. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Parse
//
//
//
//class NotificationAPICaller {
//    
//    
//    
//    
//    func onSignUp( ) {
//        
//        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
//        
//        let newUser = PFUser()
//        newUser.username = dict["name"] as! String
//        newUser.password = dict["password"] as! String
//        
//        newUser.signUpInBackground { (success: Bool, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//                
//            } else {
//                print("User \(newUser.username!) Registered in parse successfully")
//                
//            }
//        }
//    }
//    
//    
//    func signin(_ sender:Any) {
//        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
//        let username = dict["name"] as! String
//        let password = dict["password"] as! String
//        
//        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
//            if let error = error {let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
//                print("User log in failed: \(error.localizedDescription)")
//                
//            } else {
//                print("User \(username) logged in successfully")
//                
//            }
//        }
//        
//    }
//    
//    
//}
