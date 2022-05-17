//
//  ProfilesCollectionViewController.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/12/21.
//

import UIKit

class ProfilesCollectionViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: SideOptionsViewModel!
    var profilesList = [[String: AnyObject]]()
    var indexNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftBarButtonItem()
        self.viewModel = SideOptionsViewModel(delegate: self, viewController: self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ProfileCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCardCollectionViewCell")
    }
    
}

extension ProfilesCollectionViewController: SideOptionsViewModelDelegate{
    func onSuccess(with message: String) {
        self.collectionView.reloadData()
    }
    
    func onFailure(with error: String) {
        self.simpleAlert(title: nil, msg: error)
    }
    
}

extension ProfilesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profilesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCardCollectionViewCell", for: indexPath) as? ProfileCardCollectionViewCell{
            if indexNo == 0 {
                let item = (self.profilesList[indexPath.row] as? [String: AnyObject])
                let pro = item
                print(pro!["logo"])
                cell.userNameLabel.text = pro?["name"] as? String
                if let urlString = pro?["logo"] as? String{
                    cell.userImageView.setImage(url: URL(string: urlString)!)
                }
                cell.userDetailLabel.text = pro?["role"] as? String
                return cell
            }else if indexNo == 1{
                let item = (self.profilesList[indexPath.row] as? [String: AnyObject])
                let pro = item?.values.first as? [String: AnyObject]
                print(pro!["logo"])
                cell.userNameLabel.text = pro?["name"] as? String
                if let urlString = pro?["logo"] as? String{
                    cell.userImageView.setImage(url: URL(string: urlString)!)
                }
                cell.userDetailLabel.text = pro?["role"] as? String
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pro = self.profilesList[indexPath.row] as? [String: AnyObject]
        let item = pro
        
        let vc = ProfileDetailViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
        vc.name     = item?["name"] as? String ?? ""
        vc.photoUrl = item?["logo"] as? String ?? ""
        vc.detail   = item?["role"] as? String ?? ""
        vc.phone    = item?["phone"] as? String ?? ""
        vc.email    = item?["email"] as? String ?? ""
        vc.desc    = item?["info"] as? String ?? ""
        if (item?["info"] as? String ?? "") == ""{
            vc.desc    = item?["desc"] as? String ?? ""
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(self.collectionView.frame.width/2), height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
