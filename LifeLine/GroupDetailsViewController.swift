//
//  GroupDetailsViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/23/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class GroupDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var group: [String:Any]!
    var dict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self

        let groupID = group["group_id"] as! String
        
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
        let cell = UITableViewCell()

        let groupMember = dict[String(indexPath.row)] as! [String:Any]
        let memberPhone = groupMember["member_phone"] as! String
        let memberRole = groupMember["role"] as! String
        
        cell.textLabel?.text = "Member Phone: \(memberPhone), Role: \(memberRole)"
        
        return cell
    }

}
