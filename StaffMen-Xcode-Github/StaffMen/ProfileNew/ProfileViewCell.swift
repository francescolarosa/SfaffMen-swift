//
//  ProfileViewCell.swift
//  StaffMen
//
//  Created by Andrea on 24/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var lblname : UILabel!
    @IBOutlet weak var lbldescription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
