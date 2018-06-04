//
//  EditProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didSaveButton(_ sender: Any) {
        // fare il salvataggio
        dismiss(animated: true, completion: nil)
    }
    
    //x present
    func PhysicalViewController(from storyboardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let PhysicalViewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        return PhysicalViewController
    }
    
  
    @IBAction func didEditPhysicalButton(_ sender: Any) {
        let editPhysicalViewController = PhysicalViewController(from: "EditPhysicalViewController")
        present(editPhysicalViewController, animated: true)
    }
    
}
