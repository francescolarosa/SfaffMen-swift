//
//  EditPhysicalViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EditPhysicalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        pickerView4.delegate = self
        pickerView4.dataSource = self

        capelliTextField.inputView = pickerView1
        capelliTextField.textAlignment = .center
        capelliTextField.placeholder = "Select your Color"
        
        tshirtTextField.inputView = pickerView2
        tshirtTextField.textAlignment = .center
        tshirtTextField.placeholder = "Select taglia"
        
        scarpeTextField.inputView = pickerView3
        scarpeTextField.textAlignment = .center
        scarpeTextField.placeholder = "Select taglia"
        
        occhiTextField.inputView = pickerView4
        occhiTextField.textAlignment = .center
        occhiTextField.placeholder = "Select color eyes"
        
    }
    //x present
    func viewController(from storyboardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        return viewController
    }
    @IBAction func didEditPhysicalButton(_ sender: Any) {
        let editProfileViewController = viewController(from: "EditProfileViewController")
        present(editProfileViewController, animated: true)
    }

    @IBOutlet weak var capelliTextField: UITextField!
    @IBOutlet weak var tshirtTextField: UITextField!
    @IBOutlet weak var scarpeTextField: UITextField!
    @IBOutlet weak var occhiTextField: UITextField!
    
    let colors = ["castani", "biondi", "neri","rossi"]
    let tshirts = ["L", "S", "M","XL"]
    let  shoes = ["40", "41", "42","43","44"]
    let  eyes = ["neri", "marroni", "verdi","azzurri"]
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var pickerView4 = UIPickerView()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return colors.count
        } else if pickerView == pickerView2{
            return tshirts.count
        } else if pickerView == pickerView3{
            return shoes.count
        } else if pickerView == pickerView4{
            return eyes.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return colors[row]
        } else if pickerView == pickerView2{
            return tshirts[row]
        } else if pickerView == pickerView3{
            return shoes[row]
        } else if pickerView == pickerView4{
            return eyes[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        if pickerView == pickerView1{
            capelliTextField.text = colors[row]
            capelliTextField.resignFirstResponder()
        } else if pickerView == pickerView2{
            tshirtTextField.text = tshirts[row]
            tshirtTextField.resignFirstResponder()
        } else if pickerView == pickerView3{
            scarpeTextField.text = shoes[row]
            scarpeTextField.resignFirstResponder()
        } else if pickerView == pickerView4{
            occhiTextField.text = eyes[row]
            occhiTextField.resignFirstResponder()
        }
    }
}
