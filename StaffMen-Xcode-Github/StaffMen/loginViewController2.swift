//
//  loginViewController.swift
//  LoginScreen
//
//  Created by Hemita Pathak on 13/07/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    
    //MARK : Properties
    
    @IBOutlet weak var login: UILabel!
    
    @IBOutlet weak var txtusername: UITextField!
    
    
    @IBOutlet weak var txtpassword: UITextField!
    
    
    @IBOutlet weak var signin: UIButton!
    
    @IBAction func buttonAction(_ button: TransitionButton) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
           // sleep(3) // 3: Do your networking task or background work here.
            self.signintapped() // init func
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
                    let secondVC = MyProfileViewController()
                    self.present(secondVC, animated: true, completion: nil)
                })
            })
        })
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       /* login.center.x  += view.bounds.width
        txtusername.center.x  -= view.bounds.width
        txtpassword.center.x -= view.bounds.width */
        login.alpha = 0.5
        txtusername.alpha = 0.5
        txtpassword.alpha = 0.5
        //signin.alpha = 0.0
        signin.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //title will appear smooth to the screen.
        
     //   UIView.animateWithDuration(0.3, animations: {
       //     self.login.center.x += self.view.bounds.width
           // self.txtusername.center.x += self.view.bounds.width
       // })
        
       /* UIView.animateWithDuration( 1.5, delay: 0.5, usingSpringWithDamping: 0.3,
                                   initialSpringVelocity: 0.5,  options: [], animations: {self.txtusername.center.x -= self.view.bounds.width} , completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.5, options: [], animations: {self.txtpassword.center.x += self.view.bounds.width} , completion: nil) */
        
        //alpha for the fade in fade out effect
        
        UIView.animate(withDuration: 0.5, delay: 0.5,options: [],animations: {self.login.alpha = 1.0}, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5,options: [],animations: {self.txtusername.alpha = 1.0}, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5,options: [],animations: {self.txtpassword.alpha = 1.0}, completion: nil)
        
       // UIView.animateWithDuration(0.5, delay: 1.0,options: [],animations: {self.signin.alpha = 1.0}, completion: nil)
        
        //transform will show transformed size according to the co-ordinate value.
        
        UIView.animate(withDuration: 0.5, delay: 0.5,options: [],animations: {self.signin.transform = CGAffineTransform(scaleX: 1, y: 1)}, completion: nil)
        
    }
    
    
    //MARK : Actions
    
    
    @IBAction func forgotPassword(sender: UIButton) {
        
        self.performSegue(withIdentifier: "forgotpaswd", sender: self)
        
        
    }
    
    
    func signintapped() {
        
        DispatchQueue.main.async {
            
            let username : NSString = self.txtusername.text! as NSString
            let password : NSString = self.txtpassword.text! as NSString
            
            if (username.isEqual(to: "") || password.isEqual(to: ""))
            {
                
                let alertController = UIAlertController(title: "Sign In Failed !", message: "Please Enter Username and Password", preferredStyle: .alert)
                let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(deafultAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
                
            else {
                do {
                    
                    let post : NSString = "username=\(self.txtusername)&password=\(self.txtpassword)" as NSString
                    NSLog("PostData = % @", post)
                    let url : NSURL = NSURL(string: "https://dipinkrishna.com/jsonlogin2.php")!
                    let postData : NSData = post.data(using: String.Encoding.ascii.rawValue)! as NSData
                    let postLength : NSString = String(postData.length) as NSString
                    let request : NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
                    request.httpMethod = "POST"
                    request.httpBody = postData as Data
                    request.setValue(postLength as String, forHTTPHeaderField: "content length")
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content type")
                    request.setValue("application/json", forHTTPHeaderField: "Accept")
                    
                    var responseError : NSError?
                    var response : URLResponse?
                    
                    
                    var urlData : NSData?
                    
                    do {
                        
                        urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response) as NSData
                        
                    } //do 2nd
                    catch let error as NSError {
                        
                        responseError = error
                        urlData = nil
                        
                    } //catch
                    
                    if (urlData != nil) {
                        
                        let res = response as! HTTPURLResponse!
                        NSLog("Response code: %ld", res?.statusCode ?? 300);
                        //NSLog("Response code : %1d", res?.statusCode)
                        
                        
                        if (res?.statusCode)! > 200 && (res?.statusCode)! < 300 {
                            
                            let responseData : NSString = NSString(data: urlData! as Data, encoding: String.Encoding.utf8.rawValue)!
                            NSLog("response ==> %@", responseData);
                            let jsonData : NSDictionary = try! JSONSerialization.jsonObject(with: urlData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            let success : NSInteger = jsonData.value(forKey: "success") as! NSInteger
                            NSLog("success : %1d", success)
                            
                            if(success == 1) {
                                
                                NSLog("LogIn Success")
                                let prefs:UserDefaults = UserDefaults.standard
                                prefs.set(username, forKey: "USERNAME")
                                prefs.set(1, forKey: "ISLOGGEDIN")
                                prefs.synchronize()
                                self.dismiss(animated: true, completion: nil)
                            }
                                
                                
                            else {
                                
                                var error_msg : NSString
                                
                                if jsonData["Error_message"] as? NSString != nil {
                                    
                                    error_msg = jsonData["Error_message"] as! NSString
                                }
                                    
                                else {
                                    error_msg = "Unknown Error"
                                }
                                
                                let alertController = UIAlertController(title: "Sign In Failed", message: error_msg as String, preferredStyle: .alert)
                                let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                alertController.addAction(deafultAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                            
                        else {
                            
                            let alertController = UIAlertController(title: "Sign In Failed", message: "Connection Failure", preferredStyle: .alert)
                            let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alertController.addAction(deafultAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                        
                    }
                    
                    
                    
                } //do 1st
                
                
                
            } // else
        }
        
    
    } // class
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
