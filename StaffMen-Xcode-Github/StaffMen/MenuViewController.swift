//
//  MenuViewController.swift
//  StaffMen
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, ElasticMenuTransitionDelegate {
    
    var contentLength:CGFloat = 320
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    var dismissByForegroundDrag = true
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var codeView2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tm = transitioningDelegate as! ElasticTransition
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return UIStatusBarStyle.lightContent }
}
