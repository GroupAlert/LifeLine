//
//  AccelerometerController.swift
//  LifeLine
//
//  Created by Mark Falcone on 4/3/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import UIKit
import CoreMotion
import CoreLocation
import UserNotifications


class AccelerometerController: NSObject {

var motionManager = CMMotionManager()



   
    func testAccelerometer() {

        let notificationController = UNMutableNotificationContent()
        notificationController.title = "Accident Alert"
        notificationController.subtitle = "sudden accelration"
        notificationController.badge = 1
        notificationController.body = "we detected a rapid change in motion"
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "largeAcc", content: notificationController, trigger: notificationTrigger)
        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motionManager.startAccelerometerUpdates(to: OperationQueue.current! ){(data, error) in
            
                print(data as Any)
                // Get the accelerometer data.
                if let myData = self.motionManager.accelerometerData{
                    
                    print("accloromiter Data: \(myData)")
                    let x = myData.acceleration.x
                    let y = myData.acceleration.y
                    let z = myData.acceleration.z
                    if myData.acceleration.x >= 5 || myData.acceleration.y >= 5 ||
                        myData.acceleration.z >= 5{
                        print("large acclrition" )
                        // send notification
                        let dict = Archiver().getObject(fileName: "userinfo") as! NSDictionary
                        LifeLineAPICaller().getAccidentAlert(phone: dict["phone"] as! String)
                        // we need to add a chat
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    }
                  
                }
            }
        }
    }
    
    func startGyros() {
        if motionManager.isGyroAvailable {
            self.motionManager.gyroUpdateInterval = 1.0 / 60.0
            self.motionManager.startGyroUpdates()
            if let data = self.motionManager.gyroData {
                let xGyroData = data.rotationRate.x
                let yGyroData = data.rotationRate.y
                let zGyroData = data.rotationRate.z
            }
        }
        
    }

}
