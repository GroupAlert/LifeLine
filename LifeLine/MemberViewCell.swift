//
//  MemberViewCell.swift
//  LifeLine
//
//  Created by Praveen V on 4/21/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

class MemberViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    @IBOutlet var Choice: [UIButton]!
    
    @IBAction func showButtonItems(_ sender: UIButton) {
        
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
    
    
    
}
