//
//  ProfessionalDataCell.swift
//  StaffMen
//
//  Created by la rosa francesco  on 31/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation
import UIKit

class ProfessionalDataCell: UITableViewCell {
    
    @IBOutlet weak var labelLabel2: UILabel!
    @IBOutlet weak var valueLabel2: UILabel!
    
    func configure(with professionalData: ProfessionalData) {
        labelLabel2.text = professionalData.label2
        valueLabel2.text = professionalData.value2
    }
}
