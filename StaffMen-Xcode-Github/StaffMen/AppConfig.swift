//
//  Config.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

struct AppConfig {
    
    // -- Configure your Lavarel REST Api server
    static var proxy_server = "http://www.ns7records.com/staffapp/public/"
    static var public_server = "http://www.ns7records.com/staffapp/"
    
    // -- This token is past with every url request in Proxy once the session has been authenticated. 
    // -- This could also be set persistent using UserDefaults instead of a global variable
    static var apiToken: String!
    
}
