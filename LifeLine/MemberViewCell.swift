//
//  MemberViewCell.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//
import Alamofire
import UIKit

class MemberViewCell: UITableViewCell {

	@IBOutlet var picture: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var phoneLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
    }
    @IBOutlet var Choice: [UIButton]!
    
    @IBAction func handleSelection(_ sender: UIButton) {
        Choice.forEach { (button) in
            UIView.animate(withDuration: 0.5, animations:{
                button.isHidden = !button.isHidden
            })
        }
    }
    

    
    @IBAction func selectedItem(_ sender: UIButton) {
        let title = sender.currentTitle
              print(title)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
