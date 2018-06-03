//
//  addressBookTableViewCell.swift
//  addressBook
//
//  Created by user on 2018/6/1.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class addressBookTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
