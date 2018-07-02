//
//  EditProfessionalViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 03/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EditProfessionalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var provincieTextFied: UITextField!
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var experienceTextLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        //let userProfile = DataStore.shared.userProfile
          let dataStore = DataStore.shared.userProfile
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        
        // popolare i vari elementi prendendoli dal data store
        
        provincieTextFied.inputView = pickerView1
        provincieTextFied.textAlignment = .center
        provincieTextFied.placeholder = "Select your city"
        
        workTextField.inputView = pickerView2
        workTextField.textAlignment = .center
        workTextField.placeholder = dataStore?.prevJob ?? "Select your work"
        
        experienceTextLabel.inputView = pickerView3
        experienceTextLabel.textAlignment = .center
        experienceTextLabel.placeholder = "Do you have any experience?"
    }
    
    let citys = ["Milano", "Cinisello", "Bucinasco","Rozzano"]
    let works = ["Steward", "Promoter", "Modello","Driver"]
    let experience = ["Senza esperienza", "Poca esperienza", "Molta esperienza"]
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return citys.count
        }else if pickerView == pickerView2{
            return works.count
        }else if pickerView == pickerView3{
            return experience.count
        }
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return citys[row]
        } else if pickerView == pickerView2{
            return works[row]
        }else if pickerView == pickerView3{
            return experience[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // salvare sul data store gli elementu selezionati
         let dataStore = DataStore.shared
        
        if pickerView == pickerView1{
            provincieTextFied.text = citys[row]
            provincieTextFied.resignFirstResponder()
        }else if pickerView == pickerView2{
            let work = works[row]
            dataStore.userProfile?.prevJob = work
            workTextField.text = work
            workTextField.resignFirstResponder()
        }else if pickerView == pickerView3{
            experienceTextLabel.text = experience[row]
            experienceTextLabel.resignFirstResponder()
        }
    }
    
    
}
