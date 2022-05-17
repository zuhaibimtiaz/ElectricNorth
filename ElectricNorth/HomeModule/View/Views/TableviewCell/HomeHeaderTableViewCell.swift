//
//  HomeHeaderTableViewCell.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/10/21.
//

import UIKit

class HomeHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var imagebanners = [SliderImageModel]()
    var timer: Timer?
    var count = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutSubviews()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.titleView.clipsToBounds = true
        self.titleView.roundCorners([.topLeft, .bottomLeft], radius: 15)
    }
    
    func config(){
       
        
        let date = Date() // return current time and date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let dateInString = dateFormatter.string(from: date)

        print(dateInString)
        
        self.welcomeLabel.text = Global.shared.userModel.fullName + " | " + self.getGreetingText(hr: Int(dateInString) ?? 12)
        self.collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        self.collectionView.reloadData()
        self.count = 0
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        self.count += 1
        if self.count == self.imagebanners.count-1{
            self.count = 0
        }
        self.collectionView.scrollToItem(at: IndexPath(row: self.count, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func getGreetingText(hr: Int) -> String{
        if (hr < 12){
            return "בוקר טוב"
        }else if (hr >= 12 && hr <= 15){
            return "אחר הצהריים טובים"
        }else if (hr > 15 && hr < 18){
            return "ערב טוב"
        }else if (hr >= 18){
            return "לילה טוב"
        }
        return "בוקר טוב"
    }
}


extension HomeHeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagebanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell{
            cell.bannerImageView.setImage(url: URL(string: self.imagebanners[indexPath.row].image)!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
