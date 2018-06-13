//
//  LoginViewController.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import NBMaterialDialogIOS

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorsLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicator: InstagramActivityIndicator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        //activityIndicator.hidesWhenStopped = true
        //activityIndicator.stopAnimating()
        
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        let email: String = (UserDefaults.standard.object(forKey: "email") as? String)!
    //
    //
    //        let password: String = (UserDefaults.standard.object(forKey: "password") as? String)!
    //
    //        print(email)
    //        print(password)
    //
    //        if (email != nil) && (password != nil) {
    //
    //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //            appDelegate.switchBack()
    //        }
    //    }
    
    func resolve(json: JSON) {
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject, let user = data["user"] as? [String: Any] {
            //AppConfig.apiToken = user["remember_token"] as! String
            debugPrint(data)
            // debugPrint(user["remember_token"]!)
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
            NBMaterialToast.showWithText(view, text: error, duration: NBLunchDuration.medium)
        }
        
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore inserisci la email", duration: NBLunchDuration.long)
        }
        else if passwordTextField.isNull {
            NBMaterialToast.showWithText(view, text: "Per favore inserisci la password", duration: NBLunchDuration.long)
        }
        else{
            let proxy = Proxy()
            
            let params = [
                "email":emailTextField.text!,
                "password":passwordTextField.text!,
                ]
            
            
            
            
            UserDefaults.standard.set("1", forKey: "userstatus")
            
            
            //activityIndicator.startAnimating()
            indicator.startAnimating()
            proxy.submit(httpMethod: "POST", route: "/api/login", params: params, resolve: resolve, reject: reject)
            
            //self create profile
            //            let homePVC = RootPageViewController()
            //            self.present(homePVC, animated: true, completion: nil)
        }
    }
    
    //    func createProfile(
}

