//
//  GroupsViewController.swift
//  LifeLine
//
//  Created by Praveen V on 3/22/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    var dict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
        
        let userinfo = Archiver().getObject(fileName: "userinfo") as! NSDictionary
        let phone = (userinfo["phone"] as! String)
        
        let url = URL(string: LifeLineAPICaller().baseURL + "group/groupgetall.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let postString = "phone=\(phone)"
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
        //calling the AccelerometerController class
        AccelerometerController().startGyros()//start gyro
        AccelerometerController().testAccelerometer()//start acc
        //calling the speed class
        speed().testSpeed()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = dict["size"] as? Int ?? 0
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupViewCell") as! GroupViewCell

        let group = dict[String(indexPath.row)] as! [String:Any]
        let groupName = group["group_name"] as! String
        
        cell.groupName.text = groupName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "GroupsToGroup" {
            let cell = sender as! UITableViewCell
            let indexPath = table.indexPath(for: cell)!
            let group = dict[String(indexPath.row)] as! [String:Any]
            
            let detailsViewController = segue.destination as! GroupDetailsViewController
            detailsViewController.group = group
            
            table.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
