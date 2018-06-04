//
//  SignupViewController.swift
//  LoginScreen
//
//  Created by Hemita Pathak on 13/07/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    
    //MARK : Properties
    
    
    @IBOutlet weak var txtusername: UITextField!

    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var txtconfirmpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Actions
    
    
    @IBAction func signuptapped(sender: UIButton) {
        
        let username : NSString = txtusername.text! as NSString
        let password : NSString = txtpassword.text! as NSString
        let confirmpassword : NSString = txtconfirmpassword.text! as NSString
        
      /*  if (username.isEqualToString("") || password.isEqualToString(""))
         {
           // let alterView : UIAlertView = UIAlertView(title: "Sign Up Failed !", message: "Please enter Username and Password", delegate: self, cancelButtonTitle: "Ok")
            
           // alterView.show()
            
           let alertController = UIAlertController(title: "Sign Up Failed !", message: "Please Enter Username and Password", preferredStyle: .Alert)
            let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(deafultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        } //if
        else if (!password.isEqual(confirmpassword))
        
        {
         
            let alertController = UIAlertController(title: "Sign Up Failed !", message: "Password doesn't match", preferredStyle: .Alert)
            let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(deafultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        } //else if
        
        else {
            
            do {
                
                let post:NSString = "username=\(username)&password=\(password)&confirmpassword=\(confirmpassword)"
                NSLog("PostData : %@", post);
                let url:NSURL = NSURL(string: "https://dipinkrishna.com/jsonsignup.php")!
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                var reponseError: NSError?
                var response: NSURLResponse?
                
                var urlData: NSData?
                
                do {
                    
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                    
                } //do this
                
                catch let error as NSError {
                    reponseError = error
                    urlData = nil
                } //catch
                
                if (urlData != nil){
                    
                    let res = response as! NSHTTPURLResponse!;
                    
                    NSLog("Response code: %ld", res.statusCode);
                    
                    if (res.statusCode >= 200 && res.statusCode < 300)
                    {
                        
                        let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        
                        NSLog("Response ==> %@", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if (success == 1 )
                        {
                         
                            NSLog("Sign Up SUCCESS");
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        } // if success
                        
                        else {
                            
                            var error_msg :  NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                
                                error_msg = jsonData["error_message"] as! NSString
                                
                        } //if jsondata
                            
                            else {
                                
                                error_msg = "Unknown Error"
                            
                            } //else
                            
                            let alertController = UIAlertController(title: "Sign Up Failed !", message: error_msg as String, preferredStyle: .Alert)
                            let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                            alertController.addAction(deafultAction)
                            presentViewController(alertController, animated: true, completion: nil)
                            
                        } //else
                        

                    } //if statuscode
                    
                    else {
                    
                    let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failed!", preferredStyle: .Alert)
                    let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alertController.addAction(deafultAction)
                    presentViewController(alertController, animated: true, completion: nil)

                    }//else
                    
                    
                } //if urldata
                
                else {
                    
                    let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failure!", preferredStyle: .Alert)
                    let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alertController.addAction(deafultAction)
                    presentViewController(alertController, animated: true, completion: nil)
                    
                    if let error = reponseError {
                        alertController.message = (error.localizedDescription)
                    } //if
                    
                }// else
                
                } //do
                
                catch {
                    
                    let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failure!", preferredStyle: .Alert)
                    let deafultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alertController.addAction(deafultAction)
                    presentViewController(alertController, animated: true, completion: nil)
                    
                } // catch
                
                
           
            
        } //else */
            
        
        
        if ( username.isEqual(to: "") || password.isEqual(to: "") ) {
            
            let alertController = UIAlertController(title: "Sign Up Failed !", message: "Please Enter Username and Password", preferredStyle: .alert)
            let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(deafultAction)
            present(alertController, animated: true, completion: nil)
            
        } else if ( !password.isEqual(confirmpassword) ) {
            
            let alertController = UIAlertController(title: "Sign Up Failed !", message: "Password doesn't match", preferredStyle: .alert)
            let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(deafultAction)
            present(alertController, animated: true, completion: nil)

            
            
        } else {
            do {
                
                let post:NSString = "username=\(txtusername)&password=\(txtpassword)&confirmpassword=\(txtconfirmpassword)" as NSString
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string: "https://dipinkrishna.com/jsonsignup.php")!
                
                let postData:NSData = post.data(using: String.Encoding.ascii.rawValue)! as NSData
                
                let postLength:NSString = String( postData.length ) as NSString
                
                let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
                request.httpMethod = "POST"
                request.httpBody = postData as Data
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                
                var reponseError: NSError?
                var response: URLResponse?
                
                var urlData: NSData?
                do {
                   
                   // urlData = try NSURLSession.dataTaskWithRequest(request)
                    // urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                    
               
                    let urlData =  URLSession.shared.dataTask(with: request as URLRequest)
                    
                } catch let error as NSError {
                    reponseError = error
                    urlData = nil
                }
                
                if ( urlData != nil ) {
                    let res = response as! HTTPURLResponse!;
                    
                    //NSLog("Response code: %ld", res?.statusCode ?? 300);
                    NSLog("Response code: %ld", res?.statusCode ?? 300);
                    
                    if (res?.statusCode)! > 200 && (res?.statusCode)! < 300 {
                        let responseData:NSString  = NSString(data:urlData! as Data, encoding:String.Encoding.utf8.rawValue)!
                        
                        NSLog("Response ==> %@", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try! JSONSerialization.jsonObject(with: urlData! as Data, options:JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary
                        
                        
                        let success:NSInteger = jsonData.value(forKey: "success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if(success == 1)
                        {
                            NSLog("Sign Up SUCCESS");
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            
                            let alertController = UIAlertController(title: "Sign Up Failed !", message: error_msg as String, preferredStyle: .alert)
                            let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alertController.addAction(deafultAction)
                            present(alertController, animated: true, completion: nil)

                            
                        }
                        
                    };
                     
                    do {
                        
                            let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failed!", preferredStyle: .alert)
                            let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(deafultAction)
                            present(alertController, animated: true, completion: nil)
                        
                    }
                }
                 
                else
                 
                    {
                    
                        let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failure!", preferredStyle: .alert)
                        let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(deafultAction)
                        
                        if let error = reponseError {
                        alertController.message = (error.localizedDescription)
                    }
                        present(alertController, animated: true, completion: nil)
                    
                }
                
            }
            
             catch {
                
                
                let alertController = UIAlertController(title: "Sign Up Failed !", message: "Connection failure!", preferredStyle: .alert)
                let deafultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(deafultAction)
                self.present(alertController, animated: true, completion: nil)

                
            }
        
     }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
            textField.resignFirstResponder()
            return true
        }

            
        
 } // func
        
        
    @IBAction func gotoLogin(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
