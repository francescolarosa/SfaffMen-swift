//
//  EventViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EventViewController: UITableViewController {
    
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()

    let rc = UIRefreshControl()
    
    @IBOutlet weak var myTableView: UITableView!

    var myTableViewDataSource = [NewInfo]()
    
    let url = URL(string: AppConfig.proxy_server + "/api/events/json") //event index
    
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
            self.tableView.reloadData()
        }
        
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
    
    @objc private func refreshTableData(_ sender: Any) {
        // Fetch Table Data
        //myTableViewDataSource.removeAll()
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
                        //print(myJson)
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
                                    if let myLocation = value["local"] as? String
                                    {
                                        myNews.location = myLocation
                                    }
                                    if let myDate = value["date"] as? String
                                    {
                                        myNews.date = myDate
                                    }
                                    if let myDescription = value["description"] as? String
                                    {
                                        myNews.description = myDescription
                                    }
                                    if let myStartEvent = value["time_start"] as? String
                                    {
                                        myNews.startEvent = myStartEvent
                                    }
                                    if let myEndEvent = value["time_end"] as? String
                                    {
                                        myNews.endEvent = myEndEvent
                                    }
                                    if let myCost = value["cost"] as? String
                                    {
                                        myNews.cost = myCost
                                    }
                                    
                                    if let myNumMembers = value["num_members"] as? String
                                    {
                                        myNews.num_members = myNumMembers
                                    }
                                    if let myNumMembers_conf = value["num_members_confirmed"] as? String
                                    {
                                        myNews.num_members_confirmed = myNumMembers_conf
                                    }
                                    if let myId = value["id"] as? Int
                                    {
                                        myNews.id = myId
                                    }
                                    
                                    //                                    //x img
                                    //                                    if let myMultimedia = value["cover_photo"] as? [String : Any]
                                    //                                    {
                                    //                                        if let mySrc = myMultimedia["src"] as? String
                                    //                                        {
                                    //                                        myNews.src = mySrc
                                    //                                        }
                                    //                                    }
                                    self.myTableViewDataSource.append(myNews)
                                }//end loop
                                dump(self.myTableViewDataSource)
                                DispatchQueue.main.async {
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
        return 175.0;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableViewDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let myCell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        //x img//let myImageView = myCell.viewWithTag(11) as! UIImageView
        let myTitleLabel = myCell.viewWithTag(12) as! UILabel
        let myLocation = myCell.viewWithTag(13) as! UILabel
        let DateLabelCell = myCell.viewWithTag(14) as! UILabel
        let numMembLabel = myCell.viewWithTag(15) as! UILabel
        let numMembConfLabel = myCell.viewWithTag(16) as! UILabel
        
        myTitleLabel.text = myTableViewDataSource[indexPath.row].displayTitle
        myLocation.text = myTableViewDataSource[indexPath.row].location
        DateLabelCell.text = myTableViewDataSource[indexPath.row].date
        numMembLabel.text = myTableViewDataSource[indexPath.row].num_members
        numMembConfLabel.text = myTableViewDataSource[indexPath.row].num_members_confirmed
        
        
        //ximg//let myURL = myTableViewDataSource[indexPath.row].src
        //x img//loadImage(url: myURL, to: myImageView)
        return myCell
    }
//    //per passare da un viewcontroller a detailviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventDetailViewController {
            destination.model = myTableViewDataSource[(tableView.indexPathForSelectedRow?.row)!]
            
            // Effetto onda
            let vc = segue.destination
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
        }
        //menu
        if let vc = segue.destination as? MenuViewController{
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
        //endmenu
        }
}
//ximg
//    func loadImage(url: String, to imageView: UIImageView)
//    {
//        let url = URL(string: url )
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            guard let data = data else
//            {
//                return
//            }
//            DispatchQueue.main.async {
//                imageView.image = UIImage(data: data)
//
//            }
//        }.resume()
    
    //menu slide
    @objc func handlePan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .left
            transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
            //transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    //endmenuslide
    
    /// star to: (x eliminare row e x muove row)
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = myTableViewDataSource[sourceIndexPath.item]
        myTableViewDataSource.remove(at: sourceIndexPath.item)
        myTableViewDataSource.insert(movedObjTemp, at:  destinationIndexPath.item)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
//            print(indexPath.item)
        print(myTableViewDataSource[indexPath.item])
//            print(myTableViewDataSource[indexPath].id)
            guard let idEvent = (myTableViewDataSource[indexPath.item].id),
                let urlDestroy = URL(string: AppConfig.proxy_server + "/api/events/\(idEvent)/delete") else {
                return
            }
            let taskDestroy = URLSession.shared.dataTask(with: urlDestroy) {
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
                            let myJson = try JSONSerialization.jsonObject(with: content, options: .allowFragments)
                            //print(myJson)
                            if let jsonData = myJson as? [String : Any]
                            {
                                if (jsonData["data"] as? [[String : Any]]) != nil
                                {
                                    print(jsonData)
                                    self.myTableViewDataSource.remove(at : indexPath.item)
                                    //self.myTableView.deleteRows(at: [indexPath], with: .automatic)
                                    let indexPath = IndexPath(item: 0, section: 0)
                                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                    catch (let e) {
                        print(e)
                    }
                }
            }
            taskDestroy.resume()
        }
    }
    @IBAction func EditButtonTableView(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    /// end to: (x eliminare row e x muove row)
    
}

// MARK: -
// MARK: UITableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
