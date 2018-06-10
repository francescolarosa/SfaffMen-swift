//
//  MyProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//
import Foundation
import UIKit
import AlamofireImage

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    //xmenu
    @objc var transition = ElasticTransition()
    @objc let lgr = UIScreenEdgePanGestureRecognizer()
    @objc let rgr = UIScreenEdgePanGestureRecognizer()
    
    private var physicalDataViewController: PhysicalDataViewController!
    private var professionalDataViewController: ProfessionalDataViewController!
    
    private var userProfile: Login.UserProfile!
    
    private let viewModel = MyProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image picker
        imageView.backgroundColor = UIColor.lightGray
        // MENU Core
        // customization
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.3
        transition.transformType = .translateMid
        
        // menu// gesture recognizer
        lgr.addTarget(self, action: #selector(MyProfileViewController.handlePan(_:)))
        rgr.addTarget(self, action:#selector(MyProfileViewController.handleRightPan(_:)))
        lgr.edges = .left
        rgr.edges = .right
        view.addGestureRecognizer(lgr)
        view.addGestureRecognizer(rgr)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeData), for: .valueChanged)
        
        physicalDataViewController = viewController(from: "PhysicalDataViewController") as! PhysicalDataViewController
        professionalDataViewController = viewController(from: "ProfessionalDataViewController") as! ProfessionalDataViewController
        
        add(physicalDataViewController, into: containerView)
        
        viewModel.delegate = self
        viewModel.retrieveProfile()
        
        // set default values
        usernameLabel.text = "-"
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
    @objc func handleRightPan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .right
            transition.startInteractiveTransition(self, segueIdentifier: "about", gestureRecognizer: pan)
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    //endmenuslide
    
    //x menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MenuViewController{
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
            //endmenu
        }
    }
    
    @objc func didChangeData() {
        if segmentedControl.selectedSegmentIndex == 0 {
            professionalDataViewController.remove()
            add(physicalDataViewController, into: containerView)
            physicalDataViewController.refresh(with: userProfile)
        } else {
            physicalDataViewController.remove()
            add(professionalDataViewController, into: containerView)
            professionalDataViewController.refresh(with: userProfile)
        }
    }
    //x present
    func viewController(from storyboardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        return viewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //self.performSegue(withIdentifier: "mainSegue", sender: self)
        let pref : UserDefaults = UserDefaults.standard
        let isLoggedIn : Int = pref.integer(forKey: "isLoggedIn") as Int
        if (isLoggedIn != 1 )
        {
            //self.performSegue(withIdentifier: "mainSegue", sender: self)
        }
        else
        {
            //self.UsernameLabel.text = pref.value(forKey: "name") as? String
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didEditButton(_ sender: Any) {
        let editViewController = viewController(from: "EditProfileViewController") as! UINavigationController
        
        let editViewController2 =  editViewController.topViewController as! EditProfileViewController
        editViewController2.userProfile = userProfile
        present(editViewController, animated: true)        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
}

extension MyProfileViewController: MyProfileViewModelDelegate {
    func didRetrieveComlete(with userProfile: Login.UserProfile) {
        
        self.userProfile = userProfile
        
        usernameLabel.text = userProfile.name
        
        if let url = URL.init(string: "http://127.0.0.1:8000\(userProfile.photo)") {
            imageView.af_setImage(withURL: url)
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            physicalDataViewController.refresh(with: userProfile)
        } else {
            professionalDataViewController.refresh(with: userProfile)
        }
    }
    
    func didRetrieveComleteWithError() {
        print("error")
    }
    
    
}

extension Int {
    var sexDescription: String {
        if self == 1 {
            return "Maschio"
        } else {
            return "Femmina"
        }
    }
}
