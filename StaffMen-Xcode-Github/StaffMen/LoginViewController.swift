//
//  LoginViewController.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import TransitionButton

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicator: InstagramActivityIndicator!
    var regVC: RegistrationViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        //activityIndicator.hidesWhenStopped = true
        //activityIndicator.stopAnimating()
        
    }
    
    func resolve(json: JSON) {
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject,
            let user = data["user"] as? [String: Any] {
            
            if let id = user["id"] as? Int {
                UserDefaults.standard.set("\(id)", forKey: "userstatus")
            }
            
            //AppConfig.apiToken = user["remember_token"] as! String
            debugPrint(data)
            // debugPrint(user["remember_token"]!)
            performSegue(withIdentifier: "mainSegue", sender: nil)
        }
        else{
            let alertController = UIAlertController(title: "Errore Server", message: "Impossibile connettersi alle API", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func reject(json: JSON) {
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject, let error = data["msg"] as? String {
            //            self.errorsLabel.alpha = 1
            //            errorsLabel.text = ""
            //
            //            let errors = data["errors"] as! [String: Any]
            //
            //            for (key, error) in errors {
            //                let description = (error as! [String])[0] as String
            //                errorsLabel.text = errorsLabel.text! + description + " "
            //            }
            //
            //            UIView.animate(withDuration: 1.0, delay: 3.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //                self.errorsLabel.alpha = 0
            //            }, completion: nil)
            //NBMaterialToast.showWithText(view, text: error, duration: NBLunchDuration.medium)
            let alertController = UIAlertController(title: "Errore login", message: error, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func loginButton(_ sender: TransitionButton) {
        //loginButton.startAnimation()
        if emailTextField.isNull {
            let alertController = UIAlertController(title: "Inserisci Email", message: "Per favore inserisci una email valida", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if passwordTextField.isNull {
            let alertController = UIAlertController(title: "Inserisci Password", message: "Per favore inserisci una password valida", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let proxy = Proxy()
            
            let params = [
                "email":emailTextField.text!,
                "password":passwordTextField.text!,
            ]
            
            //activityIndicator.startAnimating()
            indicator.startAnimating()
            proxy.submit(httpMethod: "POST", route: "/api/login", params: params, resolve: resolve, reject: reject)
            
        }
    }
}

