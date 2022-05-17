//
//  OnBoardingViewController.swift
//  iFeeder
//
//  Created by Zuhaib  Imtiaz on 6/25/21.
//

import UIKit

class OnBoardingViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var selectedStepViews: [UIView]!
    var isSuccessShow = false
    
    var viewModel: AuthenticationViewModel!
    
    var currentPage = 0{
        didSet{
            for (i,vu) in self.selectedStepViews.enumerated(){
                vu.backgroundColor = .blue
                if i == self.currentPage{
                    vu.backgroundColor = .orange
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    fileprivate func config() {
        self.viewModel = AuthenticationViewModel(delegate: self, viewController: self)
        self.currentPage = 0
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: CollectionViewCell.OnBoardCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.OnBoardCollectionViewCell.rawValue)
        self.collectionView.register(UINib(nibName: CollectionViewCell.StepThreeCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.StepThreeCollectionViewCell.rawValue)
        self.viewModel.alreadySignIn()
    }
    
    @IBAction func actionNext(_ sender: Any){
        if self.isSuccessShow{
            self.navigationController?.pushViewController(SuccessViewController.instantiate(fromAppStoryboard: .Main), animated: true)
        }else{
            if self.currentPage == 0{
                if Global.shared.userModel.phoneNumber != ""{
                    self.viewModel.verifyPhoneNumber(phoneNumber: Global.shared.userModel.phoneNumber)
                }else{
                    self.simpleAlert(title: nil, msg: "Please enter your phone number")
                }
            }
            if self.currentPage == 1{
                if Global.shared.userModel.code != ""{
                    self.viewModel.verifyOtpCode()
                }else{
                    self.simpleAlert(title: nil, msg: "Please enter code")
                }
            }
            if self.currentPage == 2{
                if Global.shared.userModel.fullName != ""{
                    self.viewModel.registerUserOnFirebase()
                }else{
                    self.simpleAlert(title: nil, msg: "Please enter full name")
                }
            }
        }
    }
    
    func scrollToNextView() {
        self.collectionView.scrollToItem(at: IndexPath(row: self.currentPage, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension OnBoardingViewController: AuthenticationViewModelDelegate{
    func onSuccess(with message: String) {
        if message.lowercased().contains("welcome"){
            self.navigationController?.pushViewController(SuccessViewController.instantiate(fromAppStoryboard: .Main), animated: true)
            return
        }
        if self.currentPage == 2{
            self.isSuccessShow = true
            self.collectionView.reloadData()
            return
            
        }
        self.currentPage += 1
        self.scrollToNextView()
    }
    
    func onFailure(with error: String) {
        if error.lowercased().contains("please login"){
            return
        }
        self.simpleAlert(title: nil, msg: error)
    }
    
    
}



extension OnBoardingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 2{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.OnBoardCollectionViewCell.rawValue, for: indexPath) as? OnBoardCollectionViewCell{
                cell.index = indexPath.row
                cell.phoneNumberTitleLabel.isHidden = indexPath.row == 0
                cell.phoneNumberTitleLabel.text = Global.shared.userModel.phoneNumber.replacingOccurrences(of: "+972", with: "0")
                //                Global.shared.userModel.phoneNumber = "+972523505188"
                //                Global.shared.userModel.code = "123456"
                
                //                cell.phoneNumberAndCodeTextField.text = indexPath.row == 0 ? "0523505188" : "123456"
                
                // cell.config(image: self.imagesArray[indexPath.row])
                return cell
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.StepThreeCollectionViewCell.rawValue, for: indexPath) as? StepThreeCollectionViewCell{
                //                cell.fullNameTextField.text = "bilal"
                //                Global.shared.userModel.fullName = "bilal"
                //                cell.nameLabel.text = Global.shared.userModel.fullName
                
                // cell.config(image: self.imagesArray[indexPath.row])
                cell.successView.isHidden = !self.isSuccessShow
                cell.mainView.isHidden = self.isSuccessShow
                if self.isSuccessShow{
                    cell.setupAnimation()
                }
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

