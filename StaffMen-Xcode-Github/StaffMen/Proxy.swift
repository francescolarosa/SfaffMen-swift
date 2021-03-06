//
//  Proxy.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation
import UIKit

class Proxy {
    
    var lastModified: String = ""
    
    func submit(httpMethod: String, route: String, params: [String: Any], resolve: ((JSON) -> Void )?=nil, reject: ((JSON) -> Void )?=nil) {
        
        // -- Set initial URL
        let urlString = AppConfig.proxy_server + route
        
        // -- Set Request
        let request = NSMutableURLRequest(
            url: URL(string: urlString)!,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 5
        )
        
        // -- Set Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // -- Set Authentication if token exist
        if (AppConfig.apiToken != nil) {
            request.setValue("Bearer " + AppConfig.apiToken, forHTTPHeaderField: "Authorization")
        }
        
        // -- Set Method
        request.httpMethod = httpMethod
        switch (httpMethod) {
            
        case "POST", "PUT":
            
            // -- Pass parameters in body
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            
        case "GET":
            
            // -- Replace URL and append parameters to query string
            request.url = URL(string: urlString + "?" + joinParams(params: params).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! )
            
        case "DELETE": break;
            
            
        default: break;
            
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
            _ = response as? HTTPURLResponse
            
            if (error != nil) {
                
                // -- Server is not responding withing the TimeOutInterval
                //print("ProxyUrl Error: ", error)
                //reject(error)
                
                // da fare il dispatch sul main anche qui perché sto accedendo alla UI
                DispatchQueue.main.async {
                    if (UIApplication.shared.keyWindow?.rootViewController?.view) != nil {
                        //testo time out connection
                        let alert = UIAlertController(title: "Server Time Out", message: "La richiesta ha impiegato troppo tempo", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                        alert.present(alert, animated: true, completion: nil)
                    }
                }
                
            } else {
                
                DispatchQueue.main.async {
                    
                    //-- Process the JSON response
                    if let json = try? JSON(data: data!) {
                        
                        print(json)
                        
                        if json["status"].boolValue {
                            resolve!(json)
                        } else {
                            reject!(json)
                        }
                        
                    }
                    
                    //let json = try? JSON(data: data! as Data)
                    
                    // -- Pass JSON to callbacks
                    //                    if json["status"].boolValue {
                    //                        resolve!(json)
                    //                    } else {
                    //                        reject!(json)
                    //                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func joinParams(params: [String: Any] ) -> String {
        
        var out = [String]()
        for (key,value) in params {
            out.append( key + "=" + String(describing: value) )
        }
        
        return out.joined(separator: "&")
    }
    
}
