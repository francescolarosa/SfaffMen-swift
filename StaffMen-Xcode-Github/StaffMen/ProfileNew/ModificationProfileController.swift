//
//  ModificationProfileController.swift
//  StaffMen
//
//  Created by Andrea on 24/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Alamofire

class ModificationProfileController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet  var Scrollview: UIScrollView!
    @IBOutlet var ProfileimageView: UIImageView!
    @IBOutlet var newimgview: UIImageView!
    @IBOutlet var txt_name :UITextField!
    @IBOutlet var txt_jobs :UITextField!
    @IBOutlet var txt_age :UITextField!
    @IBOutlet var txt_phone :UITextField!
    @IBOutlet var txtdescription :UITextView!
    @IBOutlet var txttshirt_size :UITextField!
    @IBOutlet var txtheight :UITextField!
    @IBOutlet var txthair :UITextField!
    @IBOutlet var txtshoes_size:UITextField!
    @IBOutlet var txteyes :UITextField!
    @IBOutlet var txtsex :UITextField!

    let imagePicker = UIImagePickerController()
    var arraypicker = [String]()
    var strsex : NSString!

    var tag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arraypicker = ["male","female"];
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        Scrollview.isScrollEnabled = true
        //Scrollview.contentSize = CGSize(width: 375, height: 1200)
        Scrollview.contentSize = CGSize(width: Scrollview.contentSize.width, height: 2700)
        
        imagePicker.delegate = self
        self.pickerView.isHidden = true

        ProfileimageView.layer.cornerRadius = ProfileimageView.frame.size.width / 2
        ProfileimageView.clipsToBounds = true
       // ProfileimageView.layer.borderWidth = 2       // ProfileimageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
     {
        if textField == txtsex
        {
            self.pickerView.isHidden = false

        }
        
        return true
    }
    
    @IBAction func returnToProfile(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtsex
        {
            self.pickerView.isHidden = true
            
        }
        
        return true
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
   // func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if tag == 0 {
            ProfileimageView.contentMode = .scaleAspectFit
            ProfileimageView.image = pickedImage
        }else
            {
                newimgview.contentMode = .scaleAspectFit
                newimgview.image = pickedImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
    //func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        tag = 0
        present(imagePicker, animated: true, completion: nil)
    }
        
    @IBAction func newimageTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        tag = 1
        present(imagePicker, animated: true, completion: nil)
    }
   
    
    @IBAction func submit () {
        
        
        if (txthair.text?.isEmpty)! || (txteyes.text?.isEmpty)! || (txtshoes_size.text?.isEmpty)! || (txtheight.text?.isEmpty)! || (txt_phone.text?.isEmpty)! || (txt_age.text?.isEmpty)!
            || (txt_jobs.text?.isEmpty)! || (txtdescription.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "Alert", message: "please enter all data", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
            self.getdata(chosenImage: ProfileimageView.image!)
            
        }
        
    }
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arraypicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arraypicker[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtsex.text = arraypicker[row]
        if self.txtsex.text == "male"
        {
            strsex = "0"
        }
        else
        {
            strsex = "1"
        }
    }
    
    @IBAction func btn_cancel(sender: UIButton) {
        
        self.cleartext()
    }
    
    func cleartext() {
        
        txthair.text = ""
        txteyes.text = ""
        txtshoes_size.text = ""
        txtheight.text = ""
        txt_phone.text = ""
        txt_age.text = ""
        txt_jobs.text = ""
        txt_name.text = ""
        txt_phone.text = ""
        txtdescription.text = ""
        
        
    }
//    func getimg() {
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//    multipartFormData.append(UIImageJPEGRepresentation(self.photoImageView.image!, 0.5)!, withName: "photo_path", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//    for (key, value) in parameters {
//    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//    }
//    }, to:"http://server1/upload_img.php")
//    { (result) in
//    switch result {
//    case .success(let upload, _, _):
//
//    upload.uploadProgress(closure: { (Progress) in
//    print("Upload Progress: \(Progress.fractionCompleted)")
//    })
//
//    upload.responseJSON { response in
//    //self.delegate?.showSuccessAlert()
//    print(response.request)  // original URL request
//    print(response.response) // URL response
//    print(response.data)     // server data
//    print(response.result)   // result of response serialization
//    //                        self.showSuccesAlert()
//    //self.removeImage("frame", fileExtension: "txt")
//    if let JSON = response.result.value {
//    print("JSON: \(JSON)")
//    }
//    }
//
//    case .failure(let encodingError):
//    //self.delegate?.showFailAlert()
//    print(encodingError)
//    }
//
//    }
//    }
//
    func getdata(chosenImage: UIImage)
    
    {
    
    var userid = [Any]()
    
    if (UserDefaults.standard.object(forKey: "userstatus") as? String)! != nil
    {
    
    userid  = [(UserDefaults.standard.object(forKey: "userstatus") as? String)!]
    }
    
     //  let image = UIImage.init(named:(ProfileimageView?.image)!)
        let imageData:Data = UIImagePNGRepresentation((ProfileimageView?.image)!)!
        let imageStr = imageData.base64EncodedString()
    
        let imgData:Data = UIImagePNGRepresentation((newimgview?.image)!)!
        let imgcv = imgData.base64EncodedString()
        
    let parameters = [
    //"user_id": UserDefaults.standard.object(forKey: "userid")! ,
    "user_id": (UserDefaults.standard.object(forKey: "userstatus") as? String)! ,
    //"user_id":"7",
    "photo":imageStr,
    "name":txt_name.text! ,
    "jobs":txt_jobs.text!,
    "age":txt_age.text!,
    "location":"milano",
    "phone":txt_phone.text!,
    "sex":strsex!,
    "descr":txtdescription.text!,
    "height":txtheight.text!,
    "hair":txthair.text!,
    "shoes_size":txtshoes_size.text!,
    "cv":imgcv
    
    ] as [String : Any]
    
    print(parameters)
    
    let url = "http://www.ns7records.com/staffapp/public/api/profileupdate"
    Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
    switch response.result {
    case .success:
    print(response)
    
    // let json = response.result.value
    //
    //                if((response.result.value) != nil) {
    //                    let swiftyJsonVar = JSON(response.result.value!)
    //
    //                    let strmsg = swiftyJsonVar ["msg"] as! String
    
    // let msg = (json as! NSDictionary).value(forKey: "msg") as! String
    let alert = UIAlertController(title: "Alert", message: "Evento pubblicato correttamente!", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    
    case .failure(let error):
    print(error)
    }
    }
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
