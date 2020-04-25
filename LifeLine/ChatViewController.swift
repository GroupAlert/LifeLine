//
//  ChatViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {



    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!



    // TODO: CREATE ARRAY FOR MESSAGES
    var messages: [PFObject] = []

    // TODO: CREATE CHAT MESSAGE OBJECT
    var groupID: String = ""
    let chatMessage = PFObject(className: "groupID")
    
    var timer = Timer()


    override func viewDidLoad() {
        super.viewDidLoad()
        print("in chat")

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
        let query = PFQuery(className: "groupID") // className = group chat
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
            let chatMessage = PFObject(className: "groupID") // className = group chat
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
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
            // test the auto func
            autoMessage()
//            let chatMessage = PFObject(className: "groupID") // className = group chat
//            chatMessage["text"] = "test1"
//            chatMessage["user"] = PFUser.current()
//            chatMessage.saveInBackground()

        }
        tableView.reloadData()
    }
    // auto test message
    func autoMessage(){
        print("auto message")
        let chatMessage = PFObject(className: "groupID") // className = group id
        chatMessage["text"] = "\(PFUser.current()) was speeding at location time "
        //chatMessage["text"] = "this is a "
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground()
    }
    // methond to send a chat when a user is speeding
    func autoSpeedMessage(speed: String, location: CLLocation){
        let chatMessage = PFObject(className: "groupID") // className = group id
        chatMessage["text"] = "username" + "was goinh \(speed) "
        
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground()
    }
    //method for map radius
    func autoGeoFenceMessage(location: CLLocation){
        let chatMessage = PFObject(className: "groupID")
        chatMessage["text"] = " left the geofence and is at: \(location) "
        chatMessage["user"] = PFUser.current()
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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }



    // BONUS: IMPLEMENT CELL DIDSET
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chatCell, for: indexPath) as! ChatCell

        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String

        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }



        return cell
    }

    
}
