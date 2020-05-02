//
//  GroupSettingsViewController.swift
//  LifeLine
//
//  Created by Mark Falcone on 5/1/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class GroupSettingsViewController: UIViewController {

    
    
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var groupNameFiels: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func deleteGroup(_ sender: UIButton) {
    }
    

    @IBAction func photoButton(_ sender: Any) {
    }
    
    @IBAction func UpdateName(_ sender: UIButton) {
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
