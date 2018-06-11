//
//  EventViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()

    @IBOutlet weak var myTableView: UITableView!

    var myTableViewDataSource = [NewInfo]()
    
    let url = URL(string: "http://127.0.0.1:8000/api/events/index")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadList()
        
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
                                    if let myId = value["id"] as? Int
                                    {
                                        myNews.idEvent = myId
                                    }
                                    
                                    //                                    //x img
                                    //                                    if let myMultimedia = value[""] as? [String : Any]
                                    //                                    {
                                    //                                        if let mySrc = myMultimedia["src"] as? String
                                    //                                        {
                                    //                                        myNews.src = mySrc
                                    //                                        }
                                    //                                    }
                                    self.myTableViewDataSource.append(myNews)
                                }//end loop
                                dump(self.myTableViewDataSource)
                                DispatchQueue.main.async
                                    {
                                        self.myTableView.reloadData()
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
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)->CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let myCell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        //x img//let myImageView = myCell.viewWithTag(11) as! UIImageView
        let myTitleLabel = myCell.viewWithTag(12) as! UILabel
        let myLocation = myCell.viewWithTag(13) as! UILabel
        let DateLabelCell = myCell.viewWithTag(14) as! UILabel
        
        myTitleLabel.text = myTableViewDataSource[indexPath.row].displayTitle
        myLocation.text = myTableViewDataSource[indexPath.row].location
        DateLabelCell.text = myTableViewDataSource[indexPath.row].date
        
        //ximg//let myURL = myTableViewDataSource[indexPath.row].src
        //x img//loadImage(url: myURL, to: myImageView)
        
        return myCell
    }
    //per passare da un viewcontroller a detailviewcontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
//    //per passare da un viewcontroller a detailviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventDetailViewController {
            destination.model = myTableViewDataSource[(myTableView.indexPathForSelectedRow?.row)!]
            
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
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = myTableViewDataSource[sourceIndexPath.item]
        myTableViewDataSource.remove(at: sourceIndexPath.item)
        myTableViewDataSource.insert(movedObjTemp, at:  destinationIndexPath.item)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
//            print(indexPath.item)
        print(myTableViewDataSource[indexPath.item])
//            print(myTableViewDataSource[indexPath].id)
            guard let idEvent = (myTableViewDataSource[indexPath.item].idEvent),
                let urlDestroy = URL(string: "http://127.0.0.1:8000/events/appdestroy/\(idEvent)") else {
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
                                    self.myTableView.deleteRows(at: [indexPath], with: .automatic)
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
        self.myTableView.isEditing = !self.myTableView.isEditing
        sender.title = (self.myTableView.isEditing) ? "Done" : "Edit"
    }
    /// end to: (x eliminare row e x muove row)
    
}
