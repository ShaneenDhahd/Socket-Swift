//
//  MessageCellTableViewCell.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 01/12/2021.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

	@IBOutlet var msg: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setupMsg(msg: String){
		self.msg.text = msg
	}
    
}
