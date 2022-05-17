//
//  UIView+Extension.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 11/06/2021.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 4.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setShadowTop(offset : CGSize,color : UIColor,radius : CGFloat,opacity : Float){
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y:  layer.shadowRadius,
                                                     width: bounds.width,
                                                     height:bounds.minY - layer.shadowRadius)).cgPath
        let backgroundCGColor = layer.backgroundColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func setShadowBottom(offset : CGSize,color : UIColor,radius : CGFloat,opacity : Float){
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width + 40,
                                                     height: layer.shadowRadius)).cgPath
        let backgroundCGColor = layer.backgroundColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    
    func swipeableImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
