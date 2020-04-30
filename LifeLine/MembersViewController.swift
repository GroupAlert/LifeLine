//
//  MembersViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

var group: [String:Any]!
var dict = [String:Any]()
var groupID: String = ""
var groupNum = ""

override func viewDidLoad() {
    super.viewDidLoad()
    
    table.dataSource = self
    table.delegate = self

    //groupID = group["group_id"] as! String
    groupNum =  "group" + groupID
    let url = URL(string: LifeLineAPICaller().baseURL + "group/groupmembergetmembers.php")!
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    request.httpMethod = "POST"
    let postString = "group_id=\(groupID)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
       if let error = error {
          print(error.localizedDescription)
       } else if let data = data {
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        self.dict = dataDictionary
        self.table.reloadData()
       }
    }
    task.resume()
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let size = dict["size"] as? Int ?? 0
    return size
}

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberViewCell") as! MemberViewCell

           let groupMember = dict[String(indexPath.row)] as! [String:Any]

            cell.nameLabel.text = groupMember["name"] as! String
            cell.phoneLabel.text = groupMember["phone"] as! String




                let picStr = dict["picture"] as? String
                if picStr != nil {
                    let pictureUrl = URL(string: picStr!)!
                    Alamofire.request(pictureUrl).responseData { (response) in
                        if response.error == nil {
                                if let data = response.data {
                                    cell.photoImage.image = UIImage(data: data)
                                }
                            }
                        }
                }

                return cell
            }

    }

//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = UITableViewCell()
//
//    let groupMember = dict[String(indexPath.row)] as! [String:Any]
//    let memberPhone = groupMember["phone"] as! String
//    let memberRole = groupMember["role"] as! String
//    let memberLatitude = groupMember["latitude"] as! String
//    let memberLongitude = groupMember["longitude"] as! String
//    let memberLastSeen = groupMember["when"] as! String
//
//    cell.textLabel?.text = "Member Phone: \(memberPhone), Role: \(memberRole), Latitude: \(memberLatitude), Longitude: \(memberLongitude), Time: \(memberLastSeen)"
//
//    return cell
//}
//}






