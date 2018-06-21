//
//  provaViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 24/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class provaViewController: UIViewController {

    struct Profile : Decodable{
    
        let location : String
        
    }
    var profiles = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let jsonURL = "http://127.0.0.1:8000/api/events/index"
        let url = URL(string: jsonURL)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                self.profiles = try JSONDecoder().decode([Profile].self, from: data!)
                for eachProfile in self.profiles {
                    
                    print(eachProfile.location)
                }
            }
            catch{
                print("Error")
            }
            
            }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
