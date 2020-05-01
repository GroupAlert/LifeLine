//
//  ZonesViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/23/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class ZonesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var groupID = String()
    var phone = String()
    var zones = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self

        let url = URL(string: LifeLineAPICaller().baseURL + "zone/zonegetallmember.php")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let postString = "group_id=\(groupID)&phone=\(phone)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.zones = dataDictionary
                self.table.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = zones["size"] as? Int ?? 0
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zone = zones[String(indexPath.row)] as! [String:Any]
        let latitude = zone["latitude"] as! Double
        let longitude = zone["longitude"] as! Double
        let start = zone["timing_start"] as! String
        let end = zone["timing_end"] as! String
        let radius = zone["radius"] as! Double
        let safe = zone["safe"] as! Bool
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Latitude: \(latitude), Longitude: \(longitude), Start: \(start), End: \(end), Radius: \(radius), Safe: \(safe)"
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ZonesToZone" {
            let zone = zones[String(indexPath.row)] as! [String:Any]
            let groupDetailsViewController = segue.destination as! ChatViewController
            groupDetailsViewController.groupID = groupID
        }
    }
    */
}

