//
//  ProfessionalDataViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class ProfessionalDataViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var professionalData = ProfessionalData.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func refresh() {
        
        guard let userProfile = DataStore.shared.userProfile else {
            return
        }
        
        let professionalData = [
            ProfessionalData(label2: "POSIZIONE", value2: userProfile.prevJob),
            ProfessionalData(label2: "NUMERO", value2: userProfile.phoneNumber),
            ProfessionalData(label2: "EMAIL", value2: userProfile.email)
        ]
        
        self.professionalData = professionalData
        tableView.reloadData()
    }
     
}

extension ProfessionalDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professionalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessionalDataCell", for: indexPath) as! ProfessionalDataCell
        cell.configure(with: professionalData[indexPath.row])
        return cell
    }
    
}

extension ProfessionalDataViewController: UITableViewDelegate {
    
}
