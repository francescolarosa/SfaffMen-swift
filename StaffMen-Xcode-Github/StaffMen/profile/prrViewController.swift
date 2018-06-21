//
//  prrViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 24/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class prrViewController: UIViewController {

    
    var myTableViewDataSource = [NewInfo]()
    
    let url = URL(string: "http://127.0.0.1:8000/api/events/index")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()
      
    }
    func loadList(){
        
        var myNews = NewInfo()
        
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
                                }
//                                dump(self.myTableViewDataSource)
//                                DispatchQueue.main.async
//                                    {
//                                        self.myTableView.reloadData()
//                                }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
