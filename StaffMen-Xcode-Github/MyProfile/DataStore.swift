//
//  DataStore.swift
//  StaffMen
//
//  Created by la rosa francesco  on 16/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation

struct UserProfile {
    var age: String
    var name: String
    var phoneNumber: String
    var photo: String
    var sex: Sex
    var email: String
    var prevJob: String
    var eyes: String
    var hair: String
    var shoesSize: String
    var location: String
    var role: Role
    var tshirtSize: String
    var height: String
    var descr: String
}

extension UserProfile {
    init(json: [String: Any]) {
        age = json["age"] as? String ?? "-"
        email = json["email"] as? String ?? "-"
        eyes = json["eyes"] as? String ?? "-"
        hair = json["hair"] as? String ?? "-"
        sex = Sex.from(json["sex"] as? Int ?? 1)
        location = json["location"] as? String ?? "-"
        photo = json["photo"] as? String ?? "-"
        name = json["name"] as? String ?? "-"
        shoesSize = json["shoes_size"] as? String ?? "-"
        tshirtSize = json["tshirt_size"] as? String ?? "-"
        phoneNumber = json["phone_number"] as? String ?? "-"
        role = Role.from(json["role"] as? Int ?? 0)
        prevJob = json["prev_job"] as? String ?? "-"
        height = json["height"] as? String ?? "-"
        descr = json["descr"] as? String ?? "-"
    }
}

protocol MyProfileViewModelDelegate: class {
    func didRetrieveComleteWithSuccess()
    func didRetrieveComleteWithError()
}

class DataStore {
    static let shared = DataStore()
    
    var userProfile: UserProfile?
}
