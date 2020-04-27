//
//  ChatViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class ChatViewController: UIViewController {



    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!


    
    var messages: [PFObject] = []

    
    var groupID: String = ""
    let userDict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
    var userName: String = ""
    var timer = Timer()
    var groupNum = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        groupNum =  "group" + groupID
        self.userName = (userDict["name"] as! String) + " @ " + (userDict["phone"] as! String)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        // Reload messages every second (interval of 1 second) NOT WORKING
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        tableView.reloadData()
    }

    /*------  Message Functionality ------*/

    // TODO: ADD FUNCTIONALITY TO retrieveChatMessages()
    @objc func retrieveChatMessages() {
        let query = PFQuery(className: groupNum) // className = group chat
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }


    // TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
    @IBAction func onSend(_ sender: Any) {
        // Send message
        if messageTextField.text!.isEmpty == false {
            print(groupNum)
            let chatMessage = PFObject(className: groupNum) // className = group chat
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
            chatMessage["nameField"] = self.userName
            chatMessage["picture"] = userDict["picture"]
            
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    self.messageTextField.text = ""
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        } else {
            print("\nMessage cannot be empty\n")
        }
        tableView.reloadData()
    }
    
    // auto taccident
    func autoAccident(location: CLLocation, groupID: String){

         let groupNum = "group" + groupID
               let chatMessage = PFObject(className: groupNum) // className = group id
        chatMessage["text"] = " I may have been in an accident at \(location)"
               chatMessage["nameField"] = self.userName
               chatMessage["picture"] = userDict["picture"]
               chatMessage["user"] = PFUser.current()
               chatMessage.saveInBackground()
    }
    // methond to send a chat when a user is speeding
    func autoSpeedMessage(speed: String, location: CLLocation, groupID: String){
        let groupNum = "group" + groupID
        let chatMessage = PFObject(className: groupNum) // className = group id
        chatMessage["text"] = "Speeding at \(speed) mph"
        chatMessage["nameField"] = self.userName
        chatMessage["picture"] = userDict["picture"]
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground()
    }
    //method for map radius
    func autoGeoFenceMessage(location: CLLocation, groupID: String){
         let groupNum = "group" + groupID
        let chatMessage = PFObject(className: groupNum)
        chatMessage["text"] = " left the geofence and is at: \(location) "
        chatMessage["user"] = PFUser.current()
        chatMessage["nameField"] = self.userName
        chatMessage["picture"] = userDict["picture"]
        chatMessage.saveInBackground()
    }

    /*------ Dismiss Keyboard and Logout ------*/
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }


}


/*------ TableView Extension Functions ------*/
struct Cells {
    static let chatCell = "ChatCell"
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }



    // BONUS: IMPLEMENT CELL DIDSET
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chatCell, for: indexPath) as! ChatCell

        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        cell.usernameLabel.text = message["nameField"] as? String
        
        let picStr = message["picture"] as? String
        if picStr != nil {
            let pictureUrl = URL(string: picStr!)!
            Alamofire.request(pictureUrl).responseData { (response) in
                if response.error == nil {
                        if let data = response.data {
                            cell.picture.image = UIImage(data: data)
                        }
                    }
                }
        }

        return cell
    }

    
}
