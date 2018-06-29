//
//  RegistrationViewController.swift
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Foundation
import SwiftVideoBackground

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
    var logVC: LoginViewController!
    //Video BG
    @IBOutlet weak var videoBG: UIView!
    let videoBackground1 = VideoBackground()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load a local video
        try? videoBackground1.play(view: view, videoName: "concert-video-bg", videoType: "mp4", isMuted: true, willLoopVideo: true)
        
        navigationController?.isNavigationBarHidden = true
        
        /* or from URL */
        
        //        let url = URL(string: "https://coolVids.com/coolVid.mp4")!
        //        VideoBackground.shared.play(view: view, url: url)
        
        registerButton.layer.cornerRadius = 20
        
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        //activityIndicator.hidesWhenStopped = true
        //activityIndicator.stopAnimating()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func returnToLogin(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
            let alertController = UIAlertController(title: "Errore Server", message: "Impossibile connettersi alle API", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func reject(json: JSON) {
        
        //activityIndicator.stopAnimating()
        indicator.stopAnimating()
        if let data = json.dictionaryObject, let error = data["msg"] as? String {
            
            let alertController = UIAlertController(title: "Errore nella registrazione", message: error, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
            let alertController = UIAlertController(title: "Inserisci il nome completo", message: "Per favore inserisci un nome completo valido", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if emailTextField.isNull {
            let alertController = UIAlertController(title: "Inserisci Email", message: "Per favore inserisci una email valida", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if passwordTextField.isNull {
            let alertController = UIAlertController(title: "Inserisci Password", message: "Per favore inserisci un password valida", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if passwordConfirmTextField.isNull {
            let alertController = UIAlertController(title: "Conferma l'email", message: "Per favore conferma l'email inserita", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if passwordTextField.text != passwordConfirmTextField.text {
            let alertController = UIAlertController(title: "Ops", message: "La password e la conferma password non coincidono", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            let proxy = Proxy()
            
            let params = [
                "name": nameTextField.text!,
                "email": emailTextField.text!,
                "password": passwordTextField.text!
                //"password_confirmation": passwordConfirmTextField.text!
            ]
            
            //activityIndicator.startAnimating()
            indicator.startAnimating()
            proxy.submit(httpMethod: "POST", route: "/api/signup", params: params, resolve: resolve, reject: reject)
        }
        
    }
    
    
    
}

