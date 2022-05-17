//
//  VideoTableViewCell.swift
//  ElectricNorth
//
//  Created by Zohaib on 21/11/2021.
//

import UIKit
import YouTubePlayer

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
