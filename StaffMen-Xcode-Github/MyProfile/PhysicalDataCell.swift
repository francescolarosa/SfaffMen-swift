//
//  MyProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class PhysicalDataCell: UITableViewCell {
  @IBOutlet var labelLabel: UILabel!
  @IBOutlet var valueLabel: UILabel!
  
  func configure(with physicalData: PhysicalData) {
    labelLabel.text = physicalData.label
    valueLabel.text = physicalData.value
  }
}


