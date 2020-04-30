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
		/* Get the picture 
		let pictureUrl = URL(string: dict["picture"] as! String)!
		Alamofire.request(pictureUrl).responseData { (response) in
		if response.error == nil {
			print(response.result)
				if let data = response.data {
					self.picture.image = UIImage(data: data)
				}
			}
		}
 */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
