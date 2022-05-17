//
//  DetailsViewController.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/12/21.
//

import UIKit

class DetailsViewController: BaseViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var newsModel: NewsModel?
    var organizationDetails = [String: AnyObject]()
    
    var isFromHome = false
    var detailData :Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.descriptionLabel.isHidden = self.isFromHome
        self.bottomLabel.isHidden = self.isFromHome
        self.leftLineView.isHidden = self.isFromHome
        self.rightLineView.isHidden = self.isFromHome
        self.iconImageView.isHidden = !self.isFromHome
        self.dateLabel.isHidden = !self.isFromHome
        if self.isFromHome{
            self.configNewsDetail()
        }else{
            self.configDataDetail()
        }
    }
    
    func configNewsDetail(){
        self.mainImageView.setImage(url: URL(string: self.newsModel?.photoTitle ?? "")!)
        self.mainTitleLabel.text = self.newsModel?.title ?? ""
        self.bottomLabel.text = self.newsModel?.title ?? ""
        self.descriptionLabel.text = "\(self.newsModel?.onepar ?? "")" + "\n\n" + "\(self.newsModel?.twopar ?? "")" + "\n\n" + "\(self.newsModel?.threepar ?? "")"
        
        self.dateLabel.text = self.newsModel?.publishdate ?? ""
    }
    
    func configDataDetail(){
        if let item = detailData as? OperationListingModel{
            self.mainImageView.setImage(url: URL(string: item.photo)!)
            self.mainTitleLabel.text = item.name
            self.descriptionLabel.text = item.desc
            self.bottomLabel.text = "על הפעילות"
        }else{
            
        }
    }
}
