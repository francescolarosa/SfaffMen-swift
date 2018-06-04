//
//  MyProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct PhysicalData {
  let label: String
  let value: String
  
  static func dummy() -> [PhysicalData] {
    return [
      PhysicalData(label: "ALTEZZA (CM)", value: "145"),
      PhysicalData(label: "TAGLIA", value: "L"),
      PhysicalData(label: "COLORE CAPELLI", value: "CASTANI")
    ]
  }
}
