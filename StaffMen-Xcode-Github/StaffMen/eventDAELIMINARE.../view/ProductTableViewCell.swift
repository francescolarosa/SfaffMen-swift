//
//  ProductTableViewCell.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    func configureCellWith(_ product: Product)
    {
        productImageView.image = product.image
        productDescriptionLabel.text = product.description
        productTitleLabel.text = product.title
    }
    
}

