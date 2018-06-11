//
//  MyProfileViewModel.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

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
    
    func retrieveProfile() {
        
        let parameters = ["email" :"fprova@gmail.com", "password": "123456"]
        client.request("http://127.0.0.1:8000/api/login", parameters: parameters) { [unowned self] data in
            
            guard let data = data else {
                self.delegate?.didRetrieveComleteWithError()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let login = try decoder.decode(Login.self, from: data)
                self.delegate?.didRetrieveComlete(with: login.user)
            } catch(let e) {
                print(e)
                self.delegate?.didRetrieveComleteWithError()
            }
        }
    }
}
