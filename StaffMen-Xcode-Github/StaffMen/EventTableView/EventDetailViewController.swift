//
//  DetailViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
   
    @IBOutlet weak var TitleProva: UILabel!
    
    @IBOutlet weak var openingDateLabel: UILabel!
    
    @IBOutlet weak var srcImageStory: UIImageView!
    
    @IBOutlet weak var DateDetailLabel: UILabel!
    
    @IBOutlet weak var StartEventLabel: UILabel!
    
    @IBOutlet weak var EndEventLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    var model:NewInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        TitleProva.text = model?.displayTitle
        openingDateLabel.text = model?.location
        DateDetailLabel.text = model?.date
        StartEventLabel.text = model?.startEvent
        EndEventLabel.text = model?.endEvent
        descLabel.text = model?.description
        //srcImageStory.image = model?.src
    }

    
}
