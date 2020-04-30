//
//  MembersViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var dict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)

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
        //AccelerometerController().startGyros()
        //AccelerometerController().testAccelerometer()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = dict["size"] as? Int ?? 0
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberViewCell") as! MemberViewCell

        let group = dict[String(indexPath.row)] as! [String:Any]
        let groupName = group["group_name"] as! String
        ////////*******Copy FROM THE CHAT TO GET THE IMAGE NAME AND PHONE*********////////////
        cell.nameLabel.text =
        cell.phoneLabel =
        cell.photoImage =
        return cell
    }
    


    

}
