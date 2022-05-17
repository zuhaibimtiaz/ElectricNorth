//
//  AppStoryboard.swift
//  sibme2.0
//
//  Created by Zohaib on 18/02/2021.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case Main, Home, SideMenuOptions
    
    var instance : UIStoryboard {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let _ = Bundle.main.path(forResource: self.rawValue, ofType: "storyboardc") {
                return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
            }
        }
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

