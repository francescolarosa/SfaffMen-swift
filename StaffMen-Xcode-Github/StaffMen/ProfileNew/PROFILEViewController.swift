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
import SwiftyJSON


class PROFILEViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var Data : NSDictionary!
    @IBOutlet  var lblprofilname : UILabel!
    @IBOutlet  var lbllocation : UILabel!
    @IBOutlet var imgview: UIImageView!
    @IBOutlet var tblview : UITableView!
    @IBOutlet var tblphysicaldata : UITableView!
    var arypersonaldata : NSMutableArray!
    var  aryphysicallist : NSMutableArray!
    var flag : Bool!
    var flagphysic : Bool!
    var dic : NSMutableDictionary!
    //  var aryvaluedata: NSMutableArray()
    var aryvaluedata: NSMutableArray!
    
    
    @IBOutlet weak var btn_data_personal : UIButton!
    @IBOutlet weak var btn_physic : UIButton!
    
    
    
    @IBOutlet weak var btnmodification : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblview.isHidden = true
        self.tblphysicaldata.isHidden = true
        flag = false
        flagphysic = false
        self.getdata()
        arypersonaldata = ["Data di nascita:","inirizzo:","Email:","Ruolo:","Eta:","Sesso:","telefono:","lavoro precedent:","Bio:"]
        
        aryphysicallist = ["T-shirt Size:","Height:","Hair Colour:","Number of shoes:","Eyes Colour:"]
        self.tblview.frame.origin.y = self.btn_data_personal.frame.origin.y + self.btn_data_personal.frame.size.height + 10
        
        self.tblphysicaldata.frame.origin.y = self.btn_physic.frame.origin.y + self.btn_physic.frame.size.height
        
        //CGRect(x:self.btnd)
        // Do any additional setup after loading the view.
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
        
        self.tblphysicaldata.isHidden = true
        flagphysic = false
        
        if flag == false {
            flag = true
            self.tblview.isHidden = false
            // self.tblphysicaldata.isHidden = true
        }
        else
        {
            flag = false
            self.tblview.isHidden = true
            //  self.tblphysicaldata.isHidden = false
            
        }
        
    }
    @IBAction func btn_physical(_ sender: Any) {
        
        self.tblview.isHidden = true
        flag = false
        if flagphysic == false
        {
            flagphysic = true
            // self.tblview.isHidden = true
            self.tblphysicaldata.isHidden = false
        }
        else
        {
            flagphysic = false
            //self.tblview.isHidden = false
            self.tblphysicaldata.isHidden = true
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
            //   "id": UserDefaults.standard.object(forKey: "userid")! ,
            "id" : "15",
            ] as [String : Any]
        
        print(parameters)
        
        let url = "http://www.ns7records.com/staffapp/public/api/profile"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                //  print(response)
                
                
                
                
                
                // let JSON = response.result.value as? NSDictionary
                //  let data = JSON! ["data"] as! NSDictionary
                
                // var dic = NSDictionary()
                //  dic = data
                //  self.Data = JSON?.value(forKey: "data") as! NSDictionary
                //JSON! ["data"] as! NSDictionary
                //    self.Data = JSON?.value(forKey: "data") as! NSDictionary
                //  print(data)
                
                // let strimg = data.value(forKey: "photo") as! String
                //    let myImage = UIImage(named:strimg)
                // self.imgview.sd_setImage(with: URL(string: myImage), placeholderImage: UIImage(named: "placeholder.png"))
                
                
                // let str = (self.Data.value(forKey:"email") as! String)
                //    self.dic.setValue((self.Data.value(forKey:"email") as! String), forKey: "email")
                // self.aryvaluedata.add(str)
                //   print(self.Data.value(forKey:"email") as! String)
                
                //               self.aryvaluedata.adding((dic.value(forKey:"role") as! String))
                //    self.aryvaluedata.add((JSON?.value(forKey:"data") as? NSDictionary)?.value(forKey: "email")as! String)
                //
                //         self.aryvaluedata.add(top["age"] as? String?)
                //                self.aryvaluedata.add((self.Data.value(forKey:"prev_job") as? String)!)
                //                self.aryvaluedata.add((self.Data.value(forKey:"phone_number") as? String)!)
                //
                //                self.aryvaluedata.add((self.Data.value(forKey:"date_birthday") as? String)!)
                
                
                //  self.imgview.image = myImage
                //   self.lblprofilname.text = self.Data.value(forKey: "name") as? String
                //   self.lbllocation.text = (self.Data.value(forKey: "location") as! String)
                
                
                print(self.aryvaluedata)
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
        
        if tableView == tblview {
            
            return self.arypersonaldata.count
            
        }
        else
        {
            return self.aryphysicallist.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblview
        {
            let cell = tblview.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ProfileViewCell
            
            cell.lblname?.text = self.arypersonaldata[indexPath.row]as? String
            if self.Data != nil
            {
                cell.lbldescription?.text = self.dic.value(forKey: "email") as! String
                //self.aryvaluedata[indexPath.row]as? String
            }
            
            return cell
        }
        else
        {
            
            let cell = (tblphysicaldata.dequeueReusableCell(withIdentifier: "cell") as! PhysicalTableViewCell?)!
            
            
            //  let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for : indexPath as IndexPath)
            
            cell.lblname?.text = self.aryphysicallist[indexPath.row]as? String
            
            return cell
            
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
