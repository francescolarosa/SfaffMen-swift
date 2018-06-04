//
//  forgotpasswordViewController.swift
//  LoginScreen
//
//  Created by Hemita Pathak on 14/07/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class forgotpasswordViewController: UIViewController {
    
    
    //MARK : Properties
    
    @IBOutlet weak var txtforgotpswdlabel: UILabel!
    
    
    @IBOutlet weak var txtusername: UITextField!
    
    
    @IBOutlet weak var txtnewpassword: UITextField!
    
    
    @IBOutlet weak var txtretypepassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    
    
    @IBAction func backToLogin(sender: UIButton) {
        
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
