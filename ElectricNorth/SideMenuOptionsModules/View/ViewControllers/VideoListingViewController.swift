//
//  VideoListingViewController.swift
//  ElectricNorth
//
//  Created by Zohaib on 21/11/2021.
//

import UIKit

class VideoListingViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var viewModel: SideOptionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SideOptionsViewModel(delegate: self, viewController: self)
        self.viewModel.getVideoListing()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
    }
}

extension VideoListingViewController: SideOptionsViewModelDelegate{
    func onSuccess(with message: String) {
        self.tableView.reloadData()
    }
    
    func onFailure(with error: String) {
        self.simpleAlert(title: nil, msg: error)
    }
}

extension VideoListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalDataListings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell{
            cell.selectionStyle = .none
            let item = self.viewModel.data(at: indexPath.row)
            if let item = item as? VideoListingModel{
                cell.titleLabel.text = item.name
                cell.videoPlayer.playerVars = ["playsinline": 1 as AnyObject]
                cell.videoPlayer.loadVideoID("\(item.videoid)")
            }
            return cell
        }
        return UITableViewCell()
    }
}
