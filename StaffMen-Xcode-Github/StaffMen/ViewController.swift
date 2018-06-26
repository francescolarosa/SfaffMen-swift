////
////  ViewController.swift
////  StaffMen
////
////  Created by Andrex on 13/03/2018.
////  Copyright © 2018 Andrex. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    //Menu Ghigliottina
//    fileprivate let cellHeight: CGFloat = 210
//    fileprivate let cellSpacing: CGFloat = 20
//    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
//    
//    @IBOutlet fileprivate var barButton: UIButton!
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        print("VC: viewWillAppear")
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        print("VC: viewDidAppear")
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        print("VC: viewWillDisappear")
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        print("VC: viewDidDisappear")
//    }
//    
//    ///table view JSON (event)
//    @IBOutlet weak var tableView: UITableView!
//    
//    var heroes = [HeroStats]()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //Menu Ghigliottina
//        let navBar = self.navigationController?.navigationBar
//        navBar?.barTintColor = UIColor(
//            red: 65.0 / 255.0,
//            green: 62.0 / 255.0,
//            blue: 79.0 / 255.0,
//            alpha: 1
//        )
//        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        
//        
//        ///JSON
//        downloadJSON {
//            self.tableView.reloadData()
//        }
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    @IBAction func buttonAction(_ button: TransitionButton) {
//        button.startAnimation() // 2: Then start the animation when the user tap the button
//        let qualityOfServiceClass = DispatchQoS.QoSClass.background
//        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
//        backgroundQueue.async(execute: {
//            
//            sleep(3) // 3: Do your networking task or background work here.
//            
//            DispatchQueue.main.async(execute: { () -> Void in
//                // 4: Stop the animation, here you have three options for the `animationStyle` property:
//                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
//                // .shake: when you want to reflect to the user that the task did not complete successfly
//                // .normal
//                button.stopAnimation(animationStyle: .expand, completion: {
//                    let secondVC = SecondViewController()
//                    self.present(secondVC, animated: true, completion: nil)
//                })
//            })
//        })
//    }
//    
//    @IBAction func showMenuAction(_ sender: UIButton) {
//        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
//        menuViewController.modalPresentationStyle = .custom
//        menuViewController.transitioningDelegate = (self as UIViewControllerTransitioningDelegate)
//        
//        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
//        presentationAnimator.supportView = navigationController!.navigationBar
//        presentationAnimator.presentButton = sender
//        present(menuViewController, animated: true, completion: nil)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return heroes.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style:.default, reuseIdentifier: nil)
//        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? HeroViewController {
//            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
//        }
//    }
//    
//    func downloadJSON(completed:@escaping () ->()) {
//        let url = URL(string: "https://api.opendota.com/api/HeroStats")
//        
//        URLSession.shared.dataTask(with: url!) { (data,responce,error) in
//            if error == nil{
//                do{
//                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
//                    
//                    DispatchQueue.main.async {
//                        completed()
//                    }
//                }catch{
//                    print("JSON Error")
//                }
//            }
//            }.resume()
//    }
//}
//
//extension ViewController: UIViewControllerTransitioningDelegate {
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        presentationAnimator.mode = .presentation
//        return presentationAnimator
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        presentationAnimator.mode = .dismissal
//        return presentationAnimator
//    }
//}

