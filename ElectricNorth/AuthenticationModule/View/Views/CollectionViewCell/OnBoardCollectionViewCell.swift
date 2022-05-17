//
//  OnBoardCollectionViewCell.swift
//  iFeeder
//
//  Created by Zuhaib  Imtiaz on 6/25/21.
//

import UIKit

class OnBoardCollectionViewCell: UICollectionViewCell {

  
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    @IBOutlet weak var textFieldTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberAndCodeTextField: UITextField!
    @IBOutlet weak var noteLabel: UILabel!
    
    var index = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        self.phoneNumberAndCodeTextField.addTarget(self, action: #selector(self.textFieldDidChanged( _ :)), for: .editingChanged)
    }
    @objc func textFieldDidChanged( _ textField: UITextField){
        if self.index == 0{
            let number = textField.text!.dropFirst()
            Global.shared.userModel.phoneNumber = "+972\(number)"
        }else{
            Global.shared.userModel.code = textField.text ?? ""
        }
    }
    
    func config(mainTitle: String, subTitle: String, phoneTitle:String?, noteTitle:String, textFieldtTitle:String){
        self.mainTitleLabel.text = mainTitle
        self.subTitleLabel.text = subTitle
        self.phoneNumberTitleLabel.text = phoneTitle ?? ""
        self.noteLabel.text = noteTitle
        self.textFieldTitleLabel.text = textFieldtTitle
        self.phoneNumberTitleLabel.isHidden = phoneTitle == nil
    }

}
