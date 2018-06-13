//
//  RegistrationViewController.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import NBMaterialDialogIOS

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicator: InstagramActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 5
        
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        //activityIndicator.hidesWhenStopped = true
        //activityIndicator.stopAnimating()
        
    }
    
    func resolve(json: JSON) {
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject, let user = data["user"] as? [String: Any] {
            debugPrint(data)
            //            AppConfig.apiToken = user["api_token"] as? String
            performSegue(withIdentifier: "mainSegue", sender: nil)
        }
        else{
            NBMaterialToast.showWithText(view, text: "Ops, Qualcosa è andato storto: Riprova dopo.", duration: NBLunchDuration.medium)
        }
    }
    
    func reject(json: JSON) {
        
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject, let error = data["msg"] as? String {
            
            NBMaterialToast.showWithText(view, text: error, duration: NBLunchDuration.medium)
        }
        
        
        //        self.errorsLabel.alpha = 1
        //        errorsLabel.text = ""
        //
        //        let errors = data["errors"] as! [String: Any]
        //
        //        for (key, error) in errors {
        //            let description = (error as! [String])[0] as String
        //            errorsLabel.text = errorsLabel.text! + description + " "
        //        }
        //
        //        UIView.animate(withDuration: 1.0, delay: 3.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
        //            self.errorsLabel.alpha = 0
        //        }, completion: nil)
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        if nameTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore inserisci il nome completo", duration: NBLunchDuration.long)
        }
        else if emailTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore inserisci la email", duration: NBLunchDuration.long)
        }
        else if passwordTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore inserisci la password", duration: NBLunchDuration.long)
        }
        else if passwordConfirmTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore conferma la email", duration: NBLunchDuration.long)
        }
        else if passwordTextField.text != passwordConfirmTextField.text {
            NBMaterialToast.showWithText(view, text: "La password e la conferma password non coincide", duration: NBLunchDuration.long)
        }
        else{
            
            let proxy = Proxy()
            
            let params = [
                "name": nameTextField.text!,
                "email": emailTextField.text!,
                "password": passwordTextField.text!
                //                "password_confirmation": passwordConfirmTextField.text!
            ]
            
            //activityIndicator.startAnimating()
            indicator.startAnimating()
            proxy.submit(httpMethod: "POST", route: "/api/signup", params: params, resolve: resolve, reject: reject)
        }
        
    }
    
    
    
}
