//
//  AppleProductsTableViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 23/04/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

class AppleProductsTableViewController: UITableViewController {

    var recipes : Array<Dictionary<String, AnyObject>>!
    var productLines: [ProductLine]!
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem //1riga di cod per tasto edit , in automatico ho l'opzione elimina ,(grazie uiTableviewcontroller) (manon elimina ancora)
        
        // Make the row height dynamic
        //tableView.estimatedRowHeight = tableView.rowHeight
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        self.appIndex()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.productLines != nil {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    }
    
    func appIndex() {
        let url = URL(string: "http://127.0.0.1:8000/recipes/appIndex/all")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    //print( json["data"]?.object(at:0)) //per stampare un singolo obj dell'array
                    self.recipes = ( json["data"]as! Array<Dictionary<String, AnyObject>>)
                    self.productLines = ProductLine.productLines(self.recipes)
                    self.viewWillAppear(true)
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let productLine = productLines[section]
        return productLine.name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if productLines != nil {
            return productLines.count
        }
        else {
            return 0;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productLine = productLines[section]
        return productLine.products.count   // the number of products in the section
    }
    
    // indexPath: which section and which row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductTableViewCell
        
        let productLine = productLines[indexPath.section]
        let product = productLine.products[indexPath.row]
        
        cell.configureCellWith(product)
        
        return cell
    }
    
    // MARK: - Edit Tableview (elimina row)
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            let productLine = productLines[indexPath.section]
            let siteId =  productLine.products[indexPath.row].siteId
            let url = "http://127.0.0.1:8000/recipes/appDestroy/\(siteId)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                
                productLine.products.remove(at: indexPath.row)
                // tell the table view to update with new data source
                // tableView.reloadData()    Bad way!
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            task.resume()
        }
    }
    
    // MARK: - Moving Cells
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let productToMove = productLines[sourceIndexPath.section].products[sourceIndexPath.row]
        
        // move targetedProduct to toProducts
        productLines[destinationIndexPath.section].products.insert(productToMove, at: destinationIndexPath.row)
        
        // delete the targetedProduct to fromProducts
        productLines[sourceIndexPath.section].products.remove(at: sourceIndexPath.row)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Detail":
                let productDetailVC = segue.destination as! ProductDetailViewController
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                    productDetailVC.product = productAtIndexPath(indexPath)
                }
            case "Show Edit":
                let editTableVC = segue.destination as! EditTableViewController
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                    editTableVC.product = productAtIndexPath(indexPath)
                    editTableVC.mainController = self
                }
            case "Show Add":
                let editTableVC = segue.destination as! EditTableViewController
                editTableVC.insertMode = true
                editTableVC.mainController = self
                
            default: break
            }
        }
    }
    
    // MARK: - Helper Method
    
    func productAtIndexPath(_ indexPath: IndexPath) -> Product
    {
        let productLine = productLines[indexPath.section]
        return productLine.products[indexPath.row]
    }
    
    
    //questa e la parte per agg un newrecipe
    
}

