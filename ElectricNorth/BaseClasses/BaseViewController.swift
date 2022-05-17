//
//  BaseViewController.swift
//  Trough
//
//  Created by Irfan Malik on 17/12/2020.
//

import UIKit
import MBProgressHUD
import SDWebImage
import SideMenu

extension UIViewController{

    public func showAlert(title: String?,
                          message: String?,
                          alertStyle: UIAlertController.Style?,
                          actionTitles: [String?],
                          style: [UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)?],
                          preferredActionIndex: Int? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle ?? .actionSheet)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: style[index], handler: actions[index])
            alert.addAction(action)
        }
        if let preferredActionIndex = preferredActionIndex { alert.preferredAction = alert.actions[preferredActionIndex] }
        self.present(alert, animated: true, completion: nil)
    }
    
    func simpleAlert(title : String? , msg : String, autoDismissTime:Double = 0) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        if autoDismissTime > 0{
            GCD.async(.Main, delay: autoDismissTime) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String?, title: String? = nil, action: UIAlertAction? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            
            alertController.addAction(action ?? UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
   // moveto home was here first
    
}

//MARK: - Progress indicator methods
class BaseViewController: UIViewController {
    var hud = MBProgressHUD()
    var menuVC = SideMenuVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startActivityWithMessage (msg:String, detailMsg: String = "") {
        self.view.endEditing(true)
        self.hud = MBProgressHUD.showAdded(to: self.view, animated:true)
        self.hud.labelText = msg
        self.hud.detailsLabelText = detailMsg
        self.view.isUserInteractionEnabled = false
    }
    
    func stopActivity (containerView: UIView? = nil) {
        if let v = containerView{
            MBProgressHUD.hide(for: v, animated: true)
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        self.view.isUserInteractionEnabled = true
    }
    
    func configureSideMenu() {
//        let leftMenuButton = UIButton()
//        leftMenuButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
//        leftMenuButton.setImage(UIImage(named: "ic_menu"), for: .normal)
//        leftMenuButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
//        let barButtonItem = UIBarButtonItem(customView: leftMenuButton)
//        self.navigationItem.leftBarButtonItem = barButtonItem
//
        self.menuVC = SideMenuVC.instantiate(fromAppStoryboard: .Home)
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: self.menuVC)
        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        menuLeftNavigationController.navigationBar.isHidden = true
        menuLeftNavigationController.navigationController?.navigationBar.isHidden = true
        menuLeftNavigationController.menuWidth = UIScreen.main.bounds.width*0.95
        menuLeftNavigationController.presentationStyle = .menuSlideIn
        menuLeftNavigationController.blurEffectStyle = .none
        menuLeftNavigationController.statusBarEndAlpha = 0
        menuLeftNavigationController.presentationStyle.menuOnTop = true
        menuLeftNavigationController.presentationStyle.presentingEndAlpha = 0.4
    }
    
    @objc @IBAction func menuTapped(){
        self.present(SideMenuManager.default.leftMenuNavigationController ?? SideMenu.SideMenuNavigationController(rootViewController: self.menuVC), animated: true, completion: nil)
    }
    
    @objc @IBAction func actionBackButton(){
        self.leftNavButtonClick(UIButton())
    }
}
