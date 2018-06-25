//
//  PROFILEViewController.swift
//  StaffMen
//
//  Created by Andrea on 24/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class PROFILEViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var Data : NSDictionary!
    @IBOutlet  var lblprofilname : UILabel!
    @IBOutlet  var lbllocation : UILabel!
    @IBOutlet var imgview: UIImageView!
    @IBOutlet var tblview : UITableView!
    @IBOutlet var newtbl : UITableView!
    var arydata : NSMutableArray!
    var  arydatalist : NSMutableArray!
    var flag : Bool!
    @IBOutlet weak var btnmodification : UIButton!
    
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblview.isHidden = true
        flag = false
        self.getdata()
        arydata = ["Data di nascita","Indirizzo","Email","Lavoro","Età","Telefono"]

        // Do any additional setup after loading the view.
        // MENU Core
        // customization
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.3
        transition.transformType = .translateMid
        
        // menu// gesture recognizer
        lgr.addTarget(self, action: #selector(MyProfileViewController.handlePan(_:)))
        rgr.addTarget(self, action: #selector(MyProfileViewController.handleRightPan(_:)))
        lgr.edges = .left
        rgr.edges = .right
        view.addGestureRecognizer(lgr)
        view.addGestureRecognizer(rgr)
        
    }
    
    //menu slide
    @objc func handlePan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .left
            transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    //endmenuslide
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MenuViewController{
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
            //endmenu
        }
    }
    
    @IBAction func btn_tap_home(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_tap_modification(_ sender: Any) {
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModificationProfileController") as! ModificationProfileController
        self.present(viewController, animated: false, completion: nil)
        
    }
    
    @IBAction func btn_data_person(_ sender: Any) {
        
        if flag == false {
            flag = true
            self.tblview.isHidden = false
        }
        else
        {
            flag = false
            self.tblview.isHidden = true
        }
        
    }
    
    func getdata()
    {
        
//        var userid = [Any]()
//
//        if UserDefaults.standard.object(forKey: "userid") != nil
//        {
//
//            userid  = [UserDefaults.standard.object(forKey: "userid")!]
//        }
        
      
        let parameters = [
            "id": (UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            //"id" : "7",
            ] as [String : Any]
        
        print(parameters)
        
        let url = "http://www.ns7records.com/staffapp/public/api/profile"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
                
                let JSON = response.result.value as? NSDictionary
                self.Data = JSON! ["data"] as! NSDictionary

                let strimg = self.Data .value(forKey: "photo") as! String
                self.imgview.sd_setImage(with: URL(string: strimg), placeholderImage: UIImage(named: "restaurant2.jpg"))


                self.lblprofilname.text = self.Data.value(forKey: "name") as? String
                self.lbllocation.text = (self.Data.value(forKey: "location") as! String)

              //  self.arydatalist.add(self.Data.value(forKey: "email")as! String)
             //   self.arydatalist.adding(self.Data.value(forKey: "phone_number") as! String)
                //
                //                if((response.result.value) != nil) {
                //                    let swiftyJsonVar = JSON(response.result.value!)
                //
                //                    let strmsg = swiftyJsonVar ["msg"] as! String
                
            self.tblview.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arydata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ProfileViewCell
        
        cell.lblname.text = self.arydata[indexPath.row]as? String
        
        return cell
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
