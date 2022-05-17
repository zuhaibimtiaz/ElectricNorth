//
//  BaseFragmentView.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 15/06/2021.
//

import UIKit

class BaseFragmentView: UIView {
    weak var controller: BaseViewController?
    var resultCallback: (() -> Void)?
    private var containerView: UIView?
    
    func initalize(controller: BaseViewController, containerView: UIView) {
        self.controller = controller
        self.containerView = containerView
                
        DispatchQueue.main.async {
            containerView.addSubview(self)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    func showMe() {
        DispatchQueue.main.async {
            self.containerView?.isHidden = false
            UIView.animate(withDuration: 0.1, animations: {
                self.containerView?.alpha = 1
            })
        }
    }
    
    func hideMe() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.containerView?.alpha = 0
            }) { _ in
                self.containerView?.isHidden = true
            }
        }
    }
    
    func getContainerView() -> UIView? {
        return self.containerView
    }
}
