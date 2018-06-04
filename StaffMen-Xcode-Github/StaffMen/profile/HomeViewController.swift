//
//  HomeViewController.swift
//  StaffMen
//
//  Created by Andrex on 14/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//class HomeViewController: UIViewController {
//    
//    //MARK:Properties
//    
//    
//    @IBOutlet weak var UsernameLabel: UILabel!
//    @IBOutlet weak var nameProfile: UILabel!
//    
//    @objc var transition = ElasticTransition()
//    @objc let lgr = UIScreenEdgePanGestureRecognizer()
//    @objc let rgr = UIScreenEdgePanGestureRecognizer()
//    
//    var modelProfile:ProfileInfo?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        //loadProfile()
//        
//        nameProfile.text = modelProfile?.profile1
//        
//        // MENU Core
//        // customization
//        transition.sticky = true
//        transition.showShadow = true
//        transition.panThreshold = 0.3
//        transition.transformType = .translateMid
//        
//        //    transition.overlayColor = UIColor(white: 0, alpha: 0.5)
//        //    transition.shadowColor = UIColor(white: 0, alpha: 0.5)
//        
//        // gesture recognizer
//        lgr.addTarget(self, action: #selector(HomeViewController.handlePan(_:)))
//        rgr.addTarget(self, action: #selector(HomeViewController.handleRightPan(_:)))
//        lgr.edges = .left
//        rgr.edges = .right
//        view.addGestureRecognizer(lgr)
//        view.addGestureRecognizer(rgr)
//        
//    }
//    
//    @objc func handlePan(_ pan:UIPanGestureRecognizer){
//        if pan.state == .began{
//            transition.edge = .left
//            transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
//            //transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
//        }else{
//            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
//        }
//    }
//    
//    @objc func handleRightPan(_ pan:UIPanGestureRecognizer){
//        if pan.state == .began{
//            transition.edge = .right
//            transition.startInteractiveTransition(self, segueIdentifier: "about", gestureRecognizer: pan)
//        }else{
//            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
//        }
//    }
//    
//
//    override func viewDidAppear(_ animated: Bool) {
//        
//        super.viewDidAppear(true)
//        
//        //self.performSegue(withIdentifier: "mainSegue", sender: self)
//        
//        let pref : UserDefaults = UserDefaults.standard
//        let isLoggedIn : Int = pref.integer(forKey: "isLoggedIn") as Int
//        if (isLoggedIn != 1 )
//        {
//            //self.performSegue(withIdentifier: "mainSegue", sender: self)
//            
//        }
//            
//        else
//        {
//            
//        
//        
//            self.UsernameLabel.text = pref.value(forKey: "name") as? String
//        }
//        
//    }
//    
////    func loadProfile(){
////
////        var myProfile = ProfileInfo()
////
////        let url = URL(string: "http://127.0.0.1:8000/profile")
////
////        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
////            if error != nil
////            {
////                print("error")
////            }
////            else
////            {
////                if let content = data
////                {
////                    do
////                    {
////
////                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
////                        print(myJson)
////                        if let jsonData = myJson as? [String : Any]
////                        {
////                            if let myResults = jsonData["user"] as? [[String : Any]]
////                            {
////                                for value in myResults
////                                {
////                                    print(myResults)
////                                    if let myTitle = value["name"]  as? String
////                                    {
////                                        print(myTitle)
////                                        myProfile.profile1  = myTitle
////                                    }
////                                }
////                            }
////                        }
////                    }
////                    catch{
////
////                    }
////                }
////            }
////        }
////        task.resume()
////
////    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? MenuViewController{
//            vc.transitioningDelegate = transition
//            vc.modalPresentationStyle = .custom
//            //endmenu
//        }
//    }
//    //menu
//   
//    //MARK:Actions
//    
//    
//    @IBAction func Logoutapped(sender: UIButton) {
//        
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
//        
//        self.performSegue(withIdentifier: "mainSegue", sender: self)
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//}
