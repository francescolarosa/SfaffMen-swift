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

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var TitleProva: UILabel!
    
    @IBOutlet weak var openingDateLabel: UILabel!
    
    @IBOutlet weak var srcImageStory: UIImageView!
    
    @IBOutlet weak var DateDetailLabel: UILabel!
    
    @IBOutlet weak var StartEventLabel: UILabel!
    
    @IBOutlet weak var EndEventLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet  var Scrollview: UIScrollView!
    
     var idEvent: Int!
    
    var model:NewInfo?
    
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
        Scrollview.contentSize = CGSize(width: Scrollview.contentSize.width, height: 520)
        //
        
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        
        TitleProva.text = model.displayTitle
        openingDateLabel.text = model.location
        DateDetailLabel.text = model.date
        StartEventLabel.text = model.startEvent
        EndEventLabel.text = model.endEvent
        descLabel.text = model.description
        
        
        if let eventPhoto = model.event_photo, let imageURL = URL(string: AppConfig.public_server + eventPhoto) {
            srcImageStory.af_setImage(withURL: imageURL)
        }
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
    
    func getdata()
    {
        let parameters = [
            "user_id": (UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            "job_id": "1",
            "id": idEvent,
            
            ] as [String : Any]
        
        print(parameters)
        
        let url =  AppConfig.proxy_server + "/api/joinevent"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success:
                print(response)
                let alert = UIAlertController(title: "Pronto?", message: "Hai chiesto di unirti all'evento", preferredStyle: UIAlertControllerStyle.alert)
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
