//
//  MessagesViewController.swift
//  StaffMen
//
//  Created by Andrex on 29/06/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class MessagesViewController: UITableViewController {
    
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()
    
    let rc = UIRefreshControl()
    
    @IBOutlet weak var myTableView: UITableView!
    
    var myTableViewDataSource = [NewInfo]()
    
    let url = URL(string: "http://ns7records.com/staffapp/api/events/index")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = rc
        } else {
            tableView.addSubview(rc)
        }
        
        // Configure Refresh Control
        rc.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        let attributesRefresh = [kCTForegroundColorAttributeName: UIColor.white]
        rc.attributedTitle = NSAttributedString(string: "Caricamento ...", attributes: attributesRefresh as [NSAttributedStringKey : Any])
        
        DispatchQueue.main.async {
        }
        
        // MENU Core
        // customization
        transition.sticky = true
        transition.showShadow = true
        transition.radiusFactor = 0.8
        transition.stiffness = 0.3
        transition.containerColor = UIColor.white
        transition.panThreshold = 0.8
        transition.transformType = .rotate
        //
        
        // menu// gesture recognizer
        lgr.addTarget(self, action: #selector(MyProfileViewController.handlePan(_:)))
        rgr.addTarget(self, action: #selector(MyProfileViewController.handleRightPan(_:)))
        lgr.edges = .left
        rgr.edges = .right
        view.addGestureRecognizer(lgr)
        view.addGestureRecognizer(rgr)
        
    }
    
    @objc private func refreshTableData(_ sender: Any) {
        // Fetch Table Data
        myTableViewDataSource.removeAll()
        tableView.reloadData()
        loadList()
    }
    
    func loadList(){
        
        var myNews = NewInfo()
        
        //        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
        //
        //        })
        
        let task = URLSession.shared.dataTask(with:url!) {
            (data, response, error) in
            
            if error != nil
            {
                print("ERROR HERE..")
            }else
            {
                do
                {
                    if let content = data
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                        print(myJson)
                        if let jsonData = myJson as? [String : Any]
                        {
                            if let myResults = jsonData["data"] as? [[String : Any]]
                            {
                                //dump(myResults)
                                for value in myResults
                                {
                                    if let myTitle = value["title"]  as? String
                                    {
                                        //print(myTitle)
                                        myNews.displayTitle = myTitle
                                    }
                                    if let myUpdateDate = value["updated_at"] as? String
                                    {
                                        myNews.updated_at = myUpdateDate
                                    }
                                    if let myCreateDate = value["created_at"] as? String
                                    {
                                        myNews.created_at = myCreateDate
                                    }
                                    
                                    if let myMessages = value["messages"] as? String
                                    {
                                        myNews.message = myMessages
                                    }
                                    if let myId = value["id"] as? Int
                                    {
                                        myNews.idEvent = myId
                                    }
                                    
                                    if let myMember = value["member"] as? String
                                    {
                                        myNews.member = myMember
                                    }
                                    
                                    
                                    
                                    self.myTableViewDataSource.append(myNews)
                                }//end loop
                                dump(self.myTableViewDataSource)
                                DispatchQueue.main.async
                                    {
                                        self.tableView.reloadData()
                                        self.rc.endRefreshing()
                                }
                            }
                        }
                    }
                }
                catch{
                }
            }
        }
        task.resume()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)->CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableViewDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        let myTitleLabel = myCell.viewWithTag(12) as! UILabel
        let myLocation = myCell.viewWithTag(13) as! UILabel
        let DateLabelCell = myCell.viewWithTag(14) as! UILabel
        let numMembLabel = myCell.viewWithTag(15) as! UILabel
        
        myTitleLabel.text = myTableViewDataSource[indexPath.row].message
        myLocation.text = myTableViewDataSource[indexPath.row].member
        DateLabelCell.text = myTableViewDataSource[indexPath.row].date
        numMembLabel.text = myTableViewDataSource[indexPath.row].created_at
        return myCell
    }
    //per passare da un viewcontroller a detailviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //menu
        if let vc = segue.destination as? MenuViewController{
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
            //endmenu
        }
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
    
    //    @IBAction func EditButtonTableView(_ sender: UIBarButtonItem) {
    //        self.myTableView.isEditing = !self.myTableView.isEditing
    //        sender.title = (self.myTableView.isEditing) ? "Done" : "Edit"
    //    }
    //
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventeditViewController") as! EventeditViewController
    //        self.present(vc, animated: true, completion: nil)
    
    /// end to: (x eliminare row e x muove row)
    
}

