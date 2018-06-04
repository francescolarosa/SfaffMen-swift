//
//  EditTableViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Model:
    var product: Product?
    var insertMode = false
    var mainController : AppleProductsTableViewController!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UITextField!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.insertMode){
            title = "Add Recipe"
            
        }else{
            title = "Edit Recipe"
        }
        
        productImageView.image = product?.image
        productTitleLabel.text = product?.title
        productDescriptionTextView.text = product?.description
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        product?.title = productTitleLabel.text!
        product?.description = productDescriptionTextView.text
        product?.image = productImageView.image!
    }
    
    // MARK: - UITextFieldDelegate
    //per far funzionare la tastiera
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIScrollViewDelegate
    
    //per muovere in alto la pag quando esce la tastiera
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        productDescriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Table View Interaction
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 && indexPath.row == 0 {
            return indexPath
        } else {
            return nil
        }
    }
    
    // MARK: - Image Picker Controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0
        {
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary  // .Camera
            picker.allowsEditing = false
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        product?.image = image
        productImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func saveRecipe(_ id: Int) {
        
        let nomeRicetta = productTitleLabel.text as String!
        let descrizioneRicetta = productDescriptionTextView.text as String!
        var url = " "
        
        //create
        if id == -1{
            
            url = "http://127.0.0.1:8000/recipes/appStore/"
            
            
            url=url+"?name="+nomeRicetta!
            url=url+"&description="+descrizioneRicetta!
            url=url+"&category=primi"
            
        }else
            //update save
        {
            url = "http://127.0.0.1:8000/recipes/appUpdate/"
            
            url=url+"?name="+nomeRicetta!
            url=url+"&description="+descrizioneRicetta!
            url=url+"&id=" + String(id)
        }
        
        url = url.replacingOccurrences(of: " ", with: "%20")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            //finisco il salvaggio e richiedo nuovamente
            //al main controller la lista delle ricette
            self.mainController.appIndex();
            
        }
        task.resume()
        
    }
    
    
    //////////
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "saveAddEdit":
                
                if(self.insertMode){
                    print("create")
                    saveRecipe(-1)
                }
                else{
                    print("update")
                    saveRecipe((self.product?.siteId)!)
                }
            default: break
            }
            tableView.reloadData()
        }
    }
}

