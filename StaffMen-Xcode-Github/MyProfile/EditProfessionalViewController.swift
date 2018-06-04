//
//  EditProfessionalViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 03/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EditProfessionalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //x present
    func viewController(from storyboardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        return viewController
    }
    @IBAction func didBackBtn(_ sender: Any) {
    
        let editProfileViewController = viewController(from: "EditProfileViewController")
        present(editProfileViewController, animated: true)
    }
}
