//
//  PhysicalDataViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//
import UIKit

class PhysicalDataViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
  
    private var physicalData = [PhysicalData]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func refresh() {
        
        guard let userProfile = DataStore.shared.userProfile else {
            return
        }
        
        let physicalData = [
            PhysicalData(label: "ETA'", value: userProfile.age),
            PhysicalData(label: "SESSO", value: userProfile.sex.rawValue),
            PhysicalData(label: "OCCHI", value: userProfile.eyes),
            PhysicalData(label: "CAPELLI", value: userProfile.hair),
            PhysicalData(label: "TAGLIA SCARPE", value: userProfile.shoesSize),
            PhysicalData(label: "TAGLIA MAGLIETTA", value: userProfile.tshirtSize),
            PhysicalData(label: "ALTEZZA", value: userProfile.height)
        ]
        self.physicalData = physicalData
        tableView.reloadData()
    }
}

extension PhysicalDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return physicalData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhysicalDataCell", for: indexPath) as! PhysicalDataCell
        cell.configure(with: physicalData[indexPath.row])
        return cell
    }
}

extension PhysicalDataViewController: UITableViewDelegate {
    
  
}
