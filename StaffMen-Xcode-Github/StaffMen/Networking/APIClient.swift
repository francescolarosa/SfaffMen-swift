//
//  APIClient.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    func request(_ url: URLConvertible, parameters: Parameters, completion: @escaping (Any?) -> Void) {
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { dataResponse in            
            if let json = dataResponse.result.value {
                completion(json)
            } else {
                completion(nil)
            }
        }
    }
    
}
