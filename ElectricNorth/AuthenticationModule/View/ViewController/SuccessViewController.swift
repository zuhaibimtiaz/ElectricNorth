//
//  SuccessViewController.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/3/21.
//

import UIKit
import Lottie

class SuccessViewController: UIViewController {
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
    
    func setupAnimation(){
        animationView.animation = Animation.named("check")
        animationView.frame = self.view.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { isCompleted in
            let vc = HomeViewController.instantiate(fromAppStoryboard: .Home)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.view.addSubview(animationView)
    }
}
