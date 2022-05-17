//
//  OrganizationListingViewController.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/12/21.
//

import UIKit

class OrganizationListingViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var viewModel: SideOptionsViewModel!
    var organizationLists = [[String : AnyObject]]()
    var isLoad = true
    var isNestedMenu = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SideOptionsViewModel(delegate: self, viewController: self)
        if self.isLoad{
            self.viewModel.getOrganizationListing()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
}

extension OrganizationListingViewController: SideOptionsViewModelDelegate{
    func onSuccess(with message: String) {
        self.organizationLists = self.viewModel.organizaitionListing
        
        //                for item in self.viewModel.organizaitionListing{
        //            self.organizationLists.append(item)
        //        }
        self.tableView.reloadData()
    }
    
    func onFailure(with error: String) {
        self.simpleAlert(title: nil, msg: error)
    }    
}

extension OrganizationListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizationLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell{
            cell.selectionStyle = .none
            cell.titleLabel.text = self.organizationLists[indexPath.row]["name"] as? String
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            if (self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 0) {
                
                
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 11{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = OrganizationListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    let list = (self.organizationLists[indexPath.row]["List"] as? [[String : AnyObject]])!
                    vc.organizationLists = list
                    vc.isLoad = false
                    vc.isNestedMenu = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case 1:
            
            if self.isNestedMenu{
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 1{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                var profiles = [[String:AnyObject]]()
                let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                
                proList!.values.forEach { organizationDetail in
                    print(organizationDetail)
                    
                    profiles.append(organizationDetail as! [String : AnyObject])
                }
                let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                vc.profilesList = profiles
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        case 2:
            if self.isNestedMenu{
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 1{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case 3:
            if self.isNestedMenu{
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 1{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                let vc = OrganizationInnerListViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                let list = (self.organizationLists[indexPath.row]["List"] as? [[String : AnyObject]])!
                vc.organizationLists = list
                self.navigationController?.pushViewController(vc, animated: true)
            }
            print("name")
            
            //            if (self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 0) {
            //                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 15{
            //                    var profiles = [[String:AnyObject]]()
            //                    self.organizationLists.forEach { organizationDetail in
            //                        profiles.append(organizationDetail)
            //                    }
            //                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
            //                    vc.profilesList = profiles
            //                    vc.indexNo == 1
            //                    self.navigationController?.pushViewController(vc, animated: true)
            //                }else{
            //                    let vc = OrganizationListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
            //                    let list = (self.organizationLists[indexPath.row]["List"] as? [[String : AnyObject]])!
            //                    vc.organizationLists = list
            //                    vc.isLoad = false
            //                    self.navigationController?.pushViewController(vc, animated: true)
            //                }
            //            }
        case 4:
            if self.isNestedMenu{
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 1{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                let vc = ProfileDetailViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                let item = (self.organizationLists[indexPath.row]["0"] as? [String : AnyObject])
                vc.name     = item?["name"] as? String ?? ""
                vc.photoUrl = item?["photo"] as? String ?? ""
                vc.detail   = item?["role"] as? String ?? ""
                vc.phone    = item?["phone"] as? String ?? ""
                vc.email    = item?["email"] as? String ?? ""
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 5:
            if self.isNestedMenu{
                if self.organizationLists[indexPath.row]["List"]?.count ?? 0 > 1{
                    var profiles = [[String:AnyObject]]()
                    let proList = self.organizationLists[indexPath.row]["List"] as? Dictionary<String, AnyObject>
                    
                    proList!.values.forEach { organizationDetail in
                        print(organizationDetail)
                        
                        profiles.append(organizationDetail as! [String : AnyObject])
                    }
                    let vc = ProfilesCollectionViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                    vc.profilesList = profiles
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                let vc = ProfileDetailViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
                let item = (self.organizationLists[indexPath.row]["0"] as? [String : AnyObject])
                vc.name     = item?["name"] as? String ?? ""
                vc.photoUrl = item?["photo"] as? String ?? ""
                vc.detail   = item?["role"] as? String ?? ""
                vc.phone    = item?["phone"] as? String ?? ""
                vc.email    = item?["email"] as? String ?? ""
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 6:
            let vc = ProfileDetailViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
            let item = (self.organizationLists[indexPath.row]["0"] as? [String : AnyObject])
            vc.name     = item?["name"] as? String ?? ""
            vc.photoUrl = item?["photo"] as? String ?? ""
            vc.detail   = item?["role"] as? String ?? ""
            vc.phone    = item?["phone"] as? String ?? ""
            vc.email    = item?["email"] as? String ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = ProfileDetailViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
            let item = (self.organizationLists[indexPath.row]["0"] as? [String : AnyObject])
            vc.name     = item?["name"] as? String ?? ""
            vc.photoUrl = item?["photo"] as? String ?? ""
            vc.detail   = item?["role"] as? String ?? ""
            vc.phone    = item?["phone"] as? String ?? ""
            vc.email    = item?["email"] as? String ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            print("default...")
        }
    }
}
