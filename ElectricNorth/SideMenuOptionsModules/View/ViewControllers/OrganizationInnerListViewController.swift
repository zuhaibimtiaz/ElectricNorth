//
//  OrganizationInnerListViewController.swift
//  ElectricNorth
//
//  Created by Zuhaib Imtiaz on 5/2/22.
//

import UIKit

class OrganizationInnerListViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var organizationLists = [[String : AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
}


extension OrganizationInnerListViewController: UITableViewDelegate, UITableViewDataSource{
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
        let vc = NestedDetailsViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
        vc.mImage = self.organizationLists[indexPath.row]["photo"] as! String
        vc.name = self.organizationLists[indexPath.row]["name"] as! String
        vc.details = self.organizationLists[indexPath.row]["desc"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
