//
//  UIColor+Extension.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 01/06/2021.
//

import Foundation
import UIKit


extension UIColor {
    static let dashboardColor = UIColor(red: 75/255, green: 130/255, blue: 212/255, alpha: 1.0)
    static let uploadFileStepSelectedBackgroundColor = UIColor(red: 72/255, green: 128/255, blue: 215/255, alpha: 1.0)
    static let uploadFileStepUnselectedBackgroundColor = UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1.0)
    static let placeHolderColor = UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1.0)
    static let fileConfirmatioAttributedText = UIColor(red: 0/255, green: 190/255, blue: 123/255, alpha: 1.0)
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
