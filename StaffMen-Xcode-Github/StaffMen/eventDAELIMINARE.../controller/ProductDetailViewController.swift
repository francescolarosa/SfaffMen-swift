//
//  ProductDetailViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    // Model
    var product: Product?
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.image = product?.image
    }
    
}

