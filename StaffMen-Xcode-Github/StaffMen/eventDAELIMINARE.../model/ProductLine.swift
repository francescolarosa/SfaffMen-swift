//
//  ProductLine.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import Foundation


class ProductLine
{
    // Variables
    var name: String            // name of the product line
    var products: [Product]     // all products in the line
    
    
    init(named: String)
    {
        name = named
        products = [Product]()
    }
    
    func addProduct(_ product:Product){
        products.append(product)
    }
    
    class func productLines(_ recipes: Array<Dictionary<String, AnyObject>>) -> [ProductLine]
    {
        let antipasti = ProductLine(named: "Antipasti");
        let primi = ProductLine(named: "Primi");
        
        let secondi = ProductLine(named: "Secondi");
        let dolci = ProductLine(named: "Dolci");
        
        
        for recipe in recipes{
            
            let singleProduct = Product(titled: recipe["name"]as! String, description: recipe["description"] as! String , imageName: "apple-watch",siteId: recipe["id"] as! Int)
            
            if(recipe["category"] as! String == "antipasti"){
                antipasti.addProduct(singleProduct)
            }
            else
                if(recipe["category"] as! String == "primi"){
                    primi.addProduct(singleProduct)
                }
                else
                    if(recipe["category"] as! String == "secondi"){
                        secondi.addProduct(singleProduct)
                    }
                    else
                        if(recipe["category"] as! String == "dolci"){
                            dolci.addProduct(singleProduct)
            }
        }
        
        return [antipasti,primi,secondi,dolci]
        
    }
}
