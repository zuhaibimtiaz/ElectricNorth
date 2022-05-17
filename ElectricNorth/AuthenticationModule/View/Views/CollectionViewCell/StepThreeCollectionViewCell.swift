//
//  StepThreeCollectionViewCell.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/3/21.
//

import UIKit
import Lottie


class StepThreeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var textFieldTitle: UILabel!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var nameSecondLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    let animationView = AnimationView()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.fullNameTextField.addTarget(self, action: #selector(self.textFieldDidChanged( _ :)), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged( _ textField: UITextField){
        Global.shared.userModel.fullName = textField.text ?? ""
    }
    
    func setupAnimation(){
        animationView.animation = Animation.named("check")
        animationView.frame = self.successView.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        self.successView.addSubview(animationView)
    }

}
