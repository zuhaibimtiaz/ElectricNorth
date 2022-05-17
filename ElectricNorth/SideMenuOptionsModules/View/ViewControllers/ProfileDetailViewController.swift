//
//  ProfileDetailViewController.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 19/11/2021.
//

import UIKit

class ProfileDetailViewController: BaseViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var name     = ""
    var detail   = ""
    var photoUrl = ""
    var phone    = ""
    var email    = ""
    var desc    = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.name
        self.detailLabel.text = detail
        self.descriptionLabel.text = desc
        if photoUrl != ""{
            self.userImageView.setImage(url: URL(string: photoUrl)!)            
        }
    }
    
    @IBAction func actionPhone(){
        if let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    @IBAction func actionEmail(){
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
