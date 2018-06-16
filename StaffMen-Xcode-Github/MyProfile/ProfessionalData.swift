//
//  ProfessionalData.swift
//  StaffMen
//
//  Created by la rosa francesco  on 31/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct ProfessionalData {
    let label2: String
    let value2: String
    
    static func dummy() -> [ProfessionalData] {
        return [
            ProfessionalData(label2: "AUTOMUNITO:", value2: "SI"),
            ProfessionalData(label2: "MOTOMUNITO", value2: "NO"),
            ProfessionalData(label2: "MADRE LINGUA", value2: "ITALIANO"),
         
        ]
    }
}
