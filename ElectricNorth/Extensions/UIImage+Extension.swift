//
//  UIImage+Extension.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 03/06/2021.
//

import Foundation
import UIKit
import SDWebImage

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

extension UIImageView{
    func setImage(url:URL, placeHolderImage: String = "placeHolderImageName")  {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageIndicator?.startAnimatingIndicator()
        
        self.sd_setImage(with: url) { (img, err, cahce, URI) in
            self.sd_imageIndicator?.stopAnimatingIndicator()
            if err == nil{
                self.image = img
            }else{
                self.image = UIImage(named: placeHolderImage)
            }
        }
    }
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func makeCircle() {
        self.layoutIfNeeded()
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
}
