//
//  HomeTableViewCell.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/10/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeTitleLabel: UILabel!
    @IBOutlet weak var homeByLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(item: NewsModel){
        self.homeImageView.setImage(url: URL(string: item.photoTitle)!)
        self.homeTitleLabel.text = item.title
        self.homeByLabel.text = item.publishdate
    }
    
}
