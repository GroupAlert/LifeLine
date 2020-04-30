//
//  MembersViewController.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import CoreLocation
import MapKit
import Alamofire
import UIKit

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate  {
	
	@IBOutlet var mapView: MKMapView!
	@IBOutlet var tableView: UITableView!
	
	var groupID = String()
	var dict = [String:Any]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
		
		tableView.dataSource = self
		tableView.delegate = self
		mapView.delegate = self
		mapView.showsUserLocation = true
		
		 
		
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
		
		let pictureUrl = URL(string: groupMember["picture"] as! String)!
			Alamofire.request(pictureUrl).responseData { (response) in
			if response.error == nil {
				print(response.result)
					if let data = response.data {
						cell.picture.image = UIImage(data: data)
					}
				}
			}
		
		cell.nameLabel.text = name
		cell.bodyLabel.text = phone
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedUser = dict[String(indexPath.row)] as! [String:Any]
		let name = selectedUser["name"] as! String
		let latitude = Double(selectedUser["latitude"] as! String)
		let longitude = Double(selectedUser["longitude"] as! String)
		
		
		let selectedUserLocation = CLLocation(latitude: latitude!, longitude: longitude!)
		let region = MKCoordinateRegion(center: selectedUserLocation.coordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
		
		let userLocationAnnotation = UsersLocationAnnotation(title: name, subtitle: "Subtitle", coordinate: selectedUserLocation.coordinate)
		
		mapView.addAnnotation(userLocationAnnotation)

		
		mapView.setRegion(region, animated: true)
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		if annotation.isKind(of: MKUserLocation.self) {
			return nil
		}
		 if annotation.isKind(of: UsersLocationAnnotation.self) {
				   let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "userPin")

				   annotationView.pinTintColor = UIColor.green
				   annotationView.canShowCallout = true
				   let button = UIButton(type: .detailDisclosure)
				   annotationView.rightCalloutAccessoryView = button
				   
				   return annotationView
			   }

			   return nil
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
