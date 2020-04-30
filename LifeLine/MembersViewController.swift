//
//  MembersViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var tableView: UITableView!
	
	var groupID = String()
	var dict = [String:Any]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self
		 
		
	let url = URL(string: LifeLineAPICaller().baseURL + "group/groupmembergetmembers.php")!
			   var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
			   request.httpMethod = "POST"
		let postString = "group_id=\(self.groupID)"
			   request.httpBody = postString.data(using: String.Encoding.utf8)
			   let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
			   let task = session.dataTask(with: request) { (data, response, error) in
				  if let error = error {
					 print(error.localizedDescription)
				  } else if let data = data {
				   let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
				   self.dict = dataDictionary
				   self.tableView.reloadData()
					}
				  }
			   task.resume()
        // Do any additional setup after loading the view.
		
    }
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let size = dict["size"] as? Int ?? 0
        return size
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MemberViewCell") as! MemberViewCell
		
		let	groupMember = dict[String(indexPath.row)] as! [String:Any]
		print(groupMember)
		let name = groupMember["name"] as! String
		let phone = groupMember["phone"] as! String
		
		cell.nameLabel.text = name
		cell.bodyLabel.text = phone
		
		return cell
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
	// Pass the selecte? object to the new view controller.
    }
    */

}
