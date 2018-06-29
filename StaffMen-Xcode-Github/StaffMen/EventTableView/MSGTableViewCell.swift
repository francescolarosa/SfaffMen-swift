//
//  MSGTableViewCell.swift
//  StaffMen
//
//  Created by Andrex on 28/06/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation
import UIKit

class MSGTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileimgvw: UIImageView?
    @IBOutlet weak var lblname : UILabel!
    @IBOutlet weak var lbldescription : UILabel!
    @IBOutlet weak var lbltime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
