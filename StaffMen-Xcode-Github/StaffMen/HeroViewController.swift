//
//  HeroViewController.swift
//  StaffMen
//
//  Created by Andrex on 13/03/2018.
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
//image tableview eventi
class HeroViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var attributeLbl: UILabel!
    @IBOutlet weak var attackLable: UILabel!
    @IBOutlet weak var legsLbl: UILabel!
    
    var hero:HeroStats?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = hero?.localized_name
        attributeLbl.text = hero?.primary_attr
        attackLable.text = hero?.attack_type
        legsLbl.text =  "\((hero?.legs)!)"

        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        imageView.downloadedFrom(url: url!)
    }

}
