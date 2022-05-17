//
//  NestedDetailsViewController.swift
//  ElectricNorth
//
//  Created by Zuhaib Imtiaz on 5/2/22.
//

import UIKit

class NestedDetailsViewController: BaseViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var mImage = ""
    var name = ""
    var details = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDetail()
    }
    
    
    func configDetail(){
        self.mainImageView.setImage(url: URL(string: self.mImage)!)
        self.mainTitleLabel.text = self.name
        self.descriptionLabel.text = self.details
    }
    
}
