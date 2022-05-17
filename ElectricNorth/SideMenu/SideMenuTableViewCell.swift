//
//  SideMenuTableViewCell.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 02/06/2021.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var sideMenuImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
