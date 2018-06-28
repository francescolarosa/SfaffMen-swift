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

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var TitleProva: UILabel!
    
    @IBOutlet weak var openingDateLabel: UILabel!
    
    @IBOutlet weak var srcImageStory: UIImageView!
    
    @IBOutlet weak var DateDetailLabel: UILabel!
    
    @IBOutlet weak var StartEventLabel: UILabel!
    
    @IBOutlet weak var EndEventLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet  var Scrollview: UIScrollView!
    
    var model:NewInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let model = model else {
            return
        }
        
        //Scroll view delegate
        Scrollview.isScrollEnabled = true
        Scrollview.layer.cornerRadius = 20
        //Scrollview.contentSize = CGSize(width: 375, height: 1200)
        Scrollview.contentSize = CGSize(width: Scrollview.contentSize.width, height: 590)
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
}
