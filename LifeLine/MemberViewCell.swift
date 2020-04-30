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
	@IBOutlet var bodyLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
