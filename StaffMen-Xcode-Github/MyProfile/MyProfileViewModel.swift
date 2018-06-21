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

enum Sex: String {
    case male = "Maschio"
    case female = "Femmina"
    
    static func from(_ value: Int) -> Sex {
        if (value == 1) {
            return .male
        }
        return .female
    }
}

enum Role {
    case steward
    case organizer
    
    static func from(_ value: Int) -> Role {
        return .steward
    }
}

class MyProfileViewModel {
    
    weak var delegate: MyProfileViewModelDelegate?
    
    
    
    func resolve(json: JSON) {
        //activityIndicator.stopAnimating()
        if let data = json.dictionaryObject,
            let user = data["user"] as? [String: Any] {
            let userProfile = UserProfile(json: user)
            DataStore.shared.userProfile = userProfile
            self.delegate?.didRetrieveComleteWithSuccess()
        } else {
            self.delegate?.didRetrieveComleteWithError()
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
        self.delegate?.didRetrieveComleteWithError()
    }
    

    
    func retrieveProfile() {

        let proxy = Proxy()

        let parameters = [
            "id": (UserDefaults.standard.object(forKey: "userstatus") as? String)!,
//            "email":"info@ns7records.com",
//            "password":"andrex",
        ]

        proxy.submit(httpMethod: "POST", route: "/api/profile", params: parameters, resolve: resolve, reject: reject)
    }
}

