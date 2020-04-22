//  MapDisplayViewController.swift
//  GroupAlert
//
//  Created by Stephen Baity on 3/7/20.
//  Copyright © 2020 GroupAlert. All rights reserved.
//commit

import UIKit
import MapKit
import CoreLocation

class MapDisplayViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    let zoomedRegionInMeters: Double = 1000
	var user = NSDictionary()
	var userName = String()
	var userPhone = String()
	


    override func viewDidLoad() {
        super.viewDidLoad()
		
		user = Archiver().getObject(fileName: "userinfo") as! NSDictionary
		userName = user["name"] as! String
		userPhone = user["phone"] as! String
		
		
        checkLocationServices()
        mapView.delegate = self

        // Do any additional setup after loading the view.
    }



    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationServices () {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }

    }

    func centerViewOnUserLocation() {
        if let locationCoordinate = locationManager.location?.coordinate {
			userLocation = locationManager.location!
            let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: zoomedRegionInMeters, longitudinalMeters: zoomedRegionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String ) {
        // Make sure the devices supports region monitoring.
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            let maxDistance = 1.0
            let region = CLCircularRegion(center: locationManager.location!.coordinate,
                 radius: maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true

            locationManager.startMonitoring(for: region)

        }
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            //monitorRegionAtLocation(center: locationManager.location!.coordinate, identifier: "current")


            break
        case .denied:

            let cancelAction = UIAlertAction(title: "Ok",
                                 style: .cancel) { (action) in
            }

            let defaultAction = UIAlertAction(title: "Settings",
                                 style: .default) { (action) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }


            let alert = UIAlertController(title: "Location Services Off",
                  message: "Turn on Location Services in Settings > Privacy to allow [App Name] to determine your current location",
                  preferredStyle: .alert)

            alert.addAction(defaultAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true) {
               // The alert was presented
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //Show an alert letting them know whats up
            break
        case .authorizedAlways:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()

            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userLocation = locations.last!
		let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: zoomedRegionInMeters, longitudinalMeters: zoomedRegionInMeters)
			mapView.setRegion(region, animated: true)
		
		LifeLineAPICaller().updateLocation(phone: userPhone, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, when: "\(userLocation.timestamp)")
		
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }


    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let region = region as? CLCircularRegion {
            let identifier = region.identifier
            let defaultAction = UIAlertAction(title: "Ok",
                                 style: .cancel) { (action) in
            }


            let alert = UIAlertController(title: "Congrats",
                  message: "Region monitoring was a success, as you have left the \(identifier) region",
                  preferredStyle: .alert)

            alert.addAction(defaultAction)

            self.present(alert, animated: true) {
               // The alert was presented
            }
        }
    }


    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
