//
//  OperationsListingViewController.swift
//  ElectricNorth
//
//  Created by Zohaib on 21/11/2021.
//

import UIKit

class OperationsListingViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var viewModel: SideOptionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SideOptionsViewModel(delegate: self, viewController: self)
        self.viewModel.getOperationListing()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
}

extension OperationsListingViewController: SideOptionsViewModelDelegate{
    func onSuccess(with message: String) {
        self.tableView.reloadData()
    }
    
    func onFailure(with error: String) {
        self.simpleAlert(title: nil, msg: error)
    }
}

extension OperationsListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalDataListings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell{
            cell.selectionStyle = .none
            let item = self.viewModel.data(at: indexPath.row)
            if let item = item as? OperationListingModel{
                cell.titleLabel.text = item.name
            }else{
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.data(at: indexPath.row)
        if let item = item as? OperationListingModel {
            let vc = DetailsViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
            vc.detailData = item
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.navigationController?.pushViewController(OrganizationListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions), animated: true)
        }
        
    }
}
