//
//  ViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 01/06/18.
//  Copyright © 2018 Andrex. All rights reserved.
//


import UIKit

class Profile2ViewController: UIViewController {
  @IBOutlet var segmentedControl: UISegmentedControl!
  @IBOutlet var containerView: UIView!
  
  private var physicalDataViewController: UIViewController!
  private var professionalDataViewController: UIViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.addTarget(self, action: #selector(didChangeData), for: .valueChanged)
    
    physicalDataViewController = viewController(from: "PhysicalDataViewController")
    professionalDataViewController = viewController(from: "ProfessionalDataViewController")
    
    add(physicalDataViewController, into: containerView)
  }
  
  @objc func didChangeData() {
    if segmentedControl.selectedSegmentIndex == 0 {
      professionalDataViewController.remove()
      add(physicalDataViewController, into: containerView)
    } else {
      physicalDataViewController.remove()
      add(professionalDataViewController, into: containerView)
    }
  }
  
  func viewController(from storyboardID: String) -> UIViewController {    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
    return viewController
  }
}

