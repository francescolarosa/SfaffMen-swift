//
//  DetailViewController.swift
//  StaffMen
//
//  Created by Andrex on 20/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import AlamofireImage
import Foundation
import SwiftyJSON
import Alamofire

class EventDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var TitleProva: UILabel!
    
    @IBOutlet weak var openingDateLabel: UILabel!
    
    @IBOutlet weak var srcImageStory: UIImageView!
    
    @IBOutlet weak var DateDetailLabel: UILabel!
    
    @IBOutlet weak var StartEventLabel: UILabel!
    
    @IBOutlet weak var EndEventLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet  var Scrollview: UIScrollView!
    
    @IBOutlet  var txtmsg: UITextField!
    
    //var idEvent: Int!
    var idevent : Int?
    
    var model:NewInfo?
    var arymsgdata = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let model = model else {
            return
        }
        
        //To apply Shadow
        //Image View
        srcImageStory.layer.shadowOpacity = 1
        srcImageStory.layer.shadowRadius = 3.0
        srcImageStory.layer.shadowOffset = CGSize.zero // Use any CGSize
        srcImageStory.layer.shadowColor = UIColor.gray.cgColor
        //
        //Scroll view delegate
        Scrollview.isScrollEnabled = true
        Scrollview.layer.cornerRadius = 20
        //Scrollview.contentSize = CGSize(width: 375, height: 1200)
        Scrollview.contentSize = CGSize(width: Scrollview.contentSize.width, height: 1200)
        //
        
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        
        TitleProva.text = model.displayTitle
        openingDateLabel.text = model.location
        DateDetailLabel.text = model.date
        StartEventLabel.text = model.startEvent
        EndEventLabel.text = model.endEvent
        descLabel.text = model.description
        idevent = model.idEvent
        
        
        
        if let eventPhoto = model.event_photo, let imageURL = URL(string: AppConfig.public_server + eventPhoto) {
            srcImageStory.af_setImage(withURL: imageURL)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arymsgdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return myCell
    }
    
    
    @IBAction func btn_editevent(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventeditViewController") as! EventeditViewController
        guard let model = model else {
            return
        }
        vc.idEvent = model.idEvent
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_tap_Join (_ sender: UIButton) {
        
        self.getdata()
        
    }
    
    @IBAction func btn_tap_sendmsg (_ sender: UIButton) {
        
        self.sendmsg()
        
    }
    
    func sendmsg()
    {
        
        let parameters = [
            "user_id":(UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            "event_id":idevent!,
            "message":txtmsg.text!
            
            ] as [String : Any]
        
        print(parameters)
        
        let url =  AppConfig.proxy_server + "/api/getmessage"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success:
                print(response)
                
                //                if let data = response.result.value{
                //                    print(response.result.value!)
                //
                //                    let dic: NSDictionary =  response.result.value! as! NSDictionary
                //
                //                    self.arymsgdata = dic.value(forKey: "data") as! NSArray
                //
                
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getmsg()
    {
        
        let parameters = [
            "user_id":(UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            "id": idevent!,
            
            ] as [String : Any]
        
        print(parameters)
        
        let url =  AppConfig.proxy_server + "/api/getmessage"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success:
                print(response)
                
                if let data = response.result.value{
                    print(response.result.value!)
                    
                    
                    let dic: NSDictionary =  response.result.value! as! NSDictionary
                    
                    self.arymsgdata = dic.value(forKey: "data") as! NSArray
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getdata()
    {
        
        let parameters = [
            "user_id":(UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            "id": idevent!,
            
            ] as [String : Any]
        
        print(parameters)
        
        let url =  AppConfig.proxy_server + "/api/joinevent"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success:
                print(response)
                
                
                let alert = UIAlertController(title: "Swoosh!", message: "La tua richiesta è stata inviata", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // let json = response.result.value
                //
                //                if((response.result.value) != nil) {
                //                    let swiftyJsonVar = JSON(response.result.value!)
                //
                //                    let strmsg = swiftyJsonVar ["msg"] as! String
                
                // let msg = (json as! NSDictionary).value(forKey: "msg") as! String
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
