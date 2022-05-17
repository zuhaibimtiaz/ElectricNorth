//
//  SideMenuVC.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 02/06/2021.
//

import UIKit

struct SideMenuItem {
    var id: Int?
    var title: String?
    var image: UIImage?
}

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!

    var items: [SideMenuItem]? =
        [
            SideMenuItem(id:1, title: " חדשות ועדכונים", image: UIImage(named: "backButton")),
            SideMenuItem(id:2, title: "פעילויות ארגון העובדים", image: UIImage(named: "backButton")),
            SideMenuItem(id:3, title: "מוסדות ארגון העובדים", image: UIImage(named: "backButton")),
            SideMenuItem(id:4, title: "הארגון TV", image: UIImage(named: "backButton"))
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.name1Label.text = Global.shared.userModel.fullName
        self.name2Label.text = Global.shared.userModel.fullName
        
    }
    
}


extension SideMenuVC: UITableViewDataSource {
    
    func configureTableView() {
        DispatchQueue.main.async {
            self.tableView.separatorStyle = .none
            self.tableView.dataSource = self
            self.tableView.delegate = self            
            self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as? SideMenuTableViewCell{
            cell.selectionStyle = .none
            let item = items?[indexPath.row]
            cell.titleLabel.text = item?.title
            cell.sideMenuImageView.image = item?.image
            return cell
        }
        return UITableViewCell.init()
    }
}

extension SideMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menu = self.items?[indexPath.row]
        switch menu?.id {
        case 1:
            print("SideMenu1")
            self.dismiss(animated: true, completion: nil)
//            let vc = HomeViewController.instantiate(fromAppStoryboard: .Home)
//            vc.isFromMenu = true
//            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("Operations")
            self.navigationController?.pushViewController(OperationsListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions), animated: true)
        case 3:
            print("sideMenu3")
            self.navigationController?.pushViewController(OrganizationListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions), animated: true)

        case 4:
            print("sideMenu4")
            self.navigationController?.pushViewController(VideoListingViewController.instantiate(fromAppStoryboard: .SideMenuOptions), animated: true)
        default:
            print("invalid option")
            
        }
    }
}
