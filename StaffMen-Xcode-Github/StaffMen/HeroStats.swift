//
//  HeroStats.swift
//  StaffMen
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct HeroStats:Decodable {
    let localized_name: String
    let primary_attr:String
    let attack_type: String
    let legs: Int
    let img:String

}


