
//  HomeViewController.swift
//  Medix
//  Created by Zohaib on 28/09/2021.


import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var homeViewModel: HomeViewModel!
    var isFromMenu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = HomeViewModel(delegate: self, viewController: self)
        self.homeViewModel.getHomeData()
        self.configureSideMenu()
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tableView.register(UINib(nibName: "HomeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeHeaderTableViewCell")
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "slide"))
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.totalNewsModel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  310
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        if !isFromMenu{
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HomeHeaderTableViewCell") as! HomeHeaderTableViewCell
        if self.homeViewModel.totalSliderModel>0{
            headerCell.imagebanners = self.homeViewModel.sliderModel
            headerCell.config()
        }
        return headerCell.contentView
        //        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell{
            cell.selectionStyle = .none
            cell.config(item: self.homeViewModel.news(at: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController.instantiate(fromAppStoryboard: .SideMenuOptions)
        vc.newsModel = self.homeViewModel.news(at: indexPath.row)
        vc.isFromHome = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func onSuccess(with message: String) {
        self.tableView.reloadData()
        
    }
    
    func onFailure(with error: String) {
        
    }
    
    
    
}
