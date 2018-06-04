//
//  MyProfileViewController.swift
//  StaffMen
//
//  Created by la rosa francesco  on 29/05/18.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func add(_ child: UIViewController, into containerView: UIView) {
    addChildViewController(child)
    containerView.addSubview(child.view)
    child.didMove(toParentViewController: self)
    
    child.view.translatesAutoresizingMaskIntoConstraints = false
    
    child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    child.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
  }
  
  func remove() {
    guard parent != nil else {
      return
    }
    willMove(toParentViewController: nil)
    removeFromParentViewController()
    view.removeFromSuperview()
  }
}
