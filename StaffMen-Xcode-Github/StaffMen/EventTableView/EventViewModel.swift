//
//  EventViewModel.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct Event {
    let name: String
}

extension Event {
//    init(json: Any) {
//        name = json["name"]
//    }
}

class EventViewModel {
    let client = APIClient()
    
    func retrieveEvents() {
        
        let parameters = ["name": "Pippo"]
        client.request("", parameters: parameters) { json in
            // dal json creo il modello Event
//            let event = Event(json: json)
        }
    }
}
