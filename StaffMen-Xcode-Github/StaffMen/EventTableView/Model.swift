//
//  Model.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct NewInfo {
    //Event Model
    var user_id: Int?
    var idEvent: Int!
    var date: String?
    var displayTitle: String?
    var location: String?
    var num_members: String?
    var num_members_confirmed: String?
    var startEvent: String?
    var endEvent: String?
    var description: String?
    var cost: String?
    var event_photo: String?
    
    //Message model
    var message: String?
    var created_at: String?
    var updated_at: String?
    var member: String?
}


