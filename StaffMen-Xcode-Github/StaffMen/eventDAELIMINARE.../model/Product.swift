//
//  Product.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation
import UIKit

public enum ProductRating
{
    case unrated
    case average
    case ok
    case good
    case brilliant
}

// Represents a generic product. Need an image named "default"

class Product
{
    var title: String
    var description: String
    var image: UIImage
    var rating: ProductRating
    var siteId: Int
    
    init(titled: String, description: String, imageName: String, siteId: Int)
    {
        self.siteId = siteId
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }
        rating = .unrated
    }
}
