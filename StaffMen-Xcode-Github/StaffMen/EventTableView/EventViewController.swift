//
//  EventViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 10/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class EventViewController: UITableViewController {
    
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    let rc = UIRefreshControl()
    
    let fadeView:UIView = UIView()
    
    @IBOutlet weak var myTableView: UITableView!
    
    var myTableViewDataSource = [NewInfo]()
    
    let url = URL(string: "http://ns7records.com/staffapp/api/events/index")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navbar plain
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        ///
        // Loading view
        self.showActivityIndicator()
        ///
        //Load tableview data
        loadList()
        ///
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = rc
        } else {
            tableView.addSubview(rc)
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc private func refreshTableData(_ sender: Any) {
        // Fetch Table Data
        myTableViewDataSource.removeAll()
        tableView.reloadData()
        loadList()
    }
    
    func showActivityIndicator() {
        
        ///Loading view on table view
        //let fadeView:UIView = UIView()
        fadeView.frame = CGRectMake(0, 0, 80, 80)
        fadeView.center = self.view.center
        fadeView.backgroundColor = UIColor.darkGray
        fadeView.alpha = 0.4
        fadeView.layer.cornerRadius = 10
        self.view.addSubview(fadeView)
        self.view.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        activityView.startAnimating()
        /////
        
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        fadeView.removeFromSuperview()
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
                                    
                                    
                                    //x img
                                    //                                    if let myMultimedia = value["data"] as? [String : Any]
                                    //                                    {
                                    if let mySrc = value["event_photo"] as? String
                                    {
                                        myNews.event_photo = mySrc
                                        print(mySrc)
                                    }
                                    self.myTableViewDataSource.append(myNews)
                                }//end loop
                                dump(self.myTableViewDataSource)
                                DispatchQueue.main.async
                                    {
                                        self.tableView.reloadData()
                                        self.rc.endRefreshing()
                                        self.hideActivityIndicator()
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
        
        let myImageView = myCell.viewWithTag(11) as! UIImageView
        myImageView.layer.cornerRadius = 10;
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
        if let imageURLString = myTableViewDataSource[indexPath.row].event_photo,
            let imageURL = URL(string: AppConfig.public_server +  imageURLString) {
            myImageView.af_setImage(withURL: imageURL)
        }
        //Cell Bg
        myCell.backgroundView = UIImageView(image: UIImage())
        
        return myCell
    }
    //per passare da un viewcontroller a detailviewcontroller
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
    
    //menu slide
    @objc func handlePan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .left
            transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    //endmenuslide
    ////ximg
    func loadImage(url: String, to imageView: UIImageView)
    {
        let url = URL(string: url )
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else
            {
                return
            }
            DispatchQueue.main.async
                {
                    imageView.image = UIImage(data: data)
            }
            }.resume()
    }
    
    /// star to: (x eliminare row e x muove row)
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = myTableViewDataSource[sourceIndexPath.item]
        myTableViewDataSource.remove(at: sourceIndexPath.item)
        myTableViewDataSource.insert(movedObjTemp, at:  destinationIndexPath.item)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            // print(parameters)
            let idEvent = (myTableViewDataSource[indexPath.item].idEvent)
            let parameters = [
                //   "id": UserDefaults.standard.object(forKey: "userid")! ,
                "id" : idEvent,
                ] as [String : Any]
            
            let url = "http://www.ns7records.com/staffapp/public/api/deleteevent"
            print(url)
            Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print(response)
                    
                    let dic: NSDictionary =  response.result.value! as! NSDictionary
                    
                    //  let JSON = response.result.value as? [String : Any]
                    // let data = JSON! ["data"] as! NSDictionary
                    
                    if let jsonData = dic as? [String : Any]
                    {
                    
                        print(jsonData)
                        self.myTableViewDataSource.remove(at : indexPath.item)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                       
                    }
                    
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Aia", message: "Non puoi cancellare questo evento!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
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

//// MARK: -
//// MARK: UITableView Delegate
//
//extension UIViewController: UITableViewDelegate {
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}

