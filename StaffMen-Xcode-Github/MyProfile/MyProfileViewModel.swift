//
//  MyProfileViewModel.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

struct Login : Codable {
    struct UserProfile : Codable {
        let age: String
        let name: String
        let phoneNumber: String
        let photo: String
        let sex: Int
        let email: String
        let prev_job: String
        enum CodingKeys : String, CodingKey {
            case age
            case name
            case sex
            case photo
            case phoneNumber = "phone_number"
            case email
            case prev_job
        }
    }
    
    let user: UserProfile
}

protocol MyProfileViewModelDelegate: class {
    func didRetrieveComlete(with userProfile: Login.UserProfile)
    func didRetrieveComleteWithError()
}

class MyProfileViewModel {
    
    weak var delegate: MyProfileViewModelDelegate?
    
    let client = APIClient()
    //let proxy = Proxy()
    
    func resolve(json: JSON) {
        //activityIndicator.stopAnimating()
        if let data = json.dictionaryObject, let user = data["user"] as? [String: Any] {
            //AppConfig.apiToken = user["remember_token"] as! String
            debugPrint(data)
            // debugPrint(user["remember_token"]!)
        }
        else{
        }
    }
    
    func reject(json: JSON) {
        //activityIndicator.stopAnimating()
        if let data = json.dictionaryObject, let error = data["msg"] as? String {
            //            self.errorsLabel.alpha = 1
            //            errorsLabel.text = ""
            //
            //            let errors = data["errors"] as! [String: Any]
            //
            //            for (key, error) in errors {
            //                let description = (error as! [String])[0] as String
            //                errorsLabel.text = errorsLabel.text! + description + " "
            //            }
            //
            //            UIView.animate(withDuration: 1.0, delay: 3.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //                self.errorsLabel.alpha = 0
            //            }, completion: nil)
            //NBMaterialToast.showWithText(view, text: error, duration: NBLunchDuration.medium)
        }
        
    }
    
    func retrieveProfile() {
        let proxy = Proxy()
        
        let parameters = [
            "email":"info@ns7records.com",
            "password":"andrea",
            ]

        proxy.submit(httpMethod: "POST", route: "/api/login", params: parameters, resolve: resolve, reject: reject)
        //client.request("http://www.ns7records.com/staffapp/", parameters: parameters) { [unowned self] data in
            
//        guard let data = data else {
//                self.delegate?.didRetrieveComleteWithError()
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let login = try decoder.decode(Login.self, from: data)
//                self.delegate?.didRetrieveComlete(with: login.user)
//            } catch(let e) {
//                print(e)
//                self.delegate?.didRetrieveComleteWithError()
//            }
        
//        let params = [
//            "email":"info@ns7records.com",
//            "password":"andrea",
//            ]
//
//        UserDefaults.standard.set("1", forKey: "userstatus")
//
       
}
}

