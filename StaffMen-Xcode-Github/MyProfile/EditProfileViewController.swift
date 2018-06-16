//
//  EditProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

protocol EditProfessionalViewControllerDelegate {
    func didSaveComplete()
}

class EditProfileViewController: UIViewController {

    let picker = UIDatePicker()
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
    @IBOutlet weak var dateField: UITextField!
    
    var delegate: EditProfessionalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        if let userProfile = DataStore.shared.userProfile {
            nameLabel.text = userProfile.name
            emailTextField.text = userProfile.email
            PhoneTextField.text = userProfile.phoneNumber
        }
    }
    
    @IBAction func didSaveButton(_ sender: Any) {
        
        let dataStore = DataStore.shared
        
        dataStore.userProfile?.name = nameLabel.text ?? "-"
        dataStore.userProfile?.email = emailTextField.text ?? "-"
        dataStore.userProfile?.phoneNumber = PhoneTextField.text ?? "-"
        
        // salvare sul data store anche (vedi sopra)
        // - data nascita
        
        // Invocare il servizio
        // Chiedere ad Andrea quale route deve essere invocato
        // let proxy = Proxy()
        // let parameters = ["name": dataStore.userProfile?.name,etc.]
        // proxy.submit(httpMethod: "POST", route: "/api/editProfile", params: parameters, resolve: { jsonData in
            // salvataggio riuscito
        // }, reject: { dataJson in
            // salvataggio non riuscito
        // })
        
        dismiss(animated: true) {
            // Questo metodo viene invocato nel MyProfileViewController
            self.delegate?.didSaveComplete()
        }
    }
    
    func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        
        // format picker for date
        picker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
}
