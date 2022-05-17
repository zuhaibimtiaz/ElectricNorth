

import Foundation
import UIKit
import SwiftKeychainWrapper
import PDFKit

//MARK: -  UIViewController
extension UIViewController:UIGestureRecognizerDelegate{
    @objc func leftBarButtonItem(){
        // hide default navigation bar button item
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        let buttonBack: UIButton = UIButton(type: .custom) as UIButton
        buttonBack.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        buttonBack.setImage(UIImage(named:"backButton"), for: UIControl.State())
        buttonBack.addTarget(self, action:#selector(self.leftNavButtonClick(_:)), for: UIControl.Event.touchUpInside)
        buttonBack.transform = CGAffineTransform(translationX: -10, y: 0)
        // add the button to a container, otherwise the transform will be ignored
        let suggestButtonContainer = UIView(frame: buttonBack.frame)
        suggestButtonContainer.addSubview(buttonBack)
        let suggestButtonItem = UIBarButtonItem(customView: suggestButtonContainer)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        self.navigationItem.setLeftBarButton(suggestButtonItem, animated: false);
        
        //  self.navigationController!.navigationBar.isTranslucent = false;
    }
    
    @objc func configureNavigationForSearch(isDefault:Bool = false) {
        if isDefault{
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.barTintColor = nil
        }else{
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 253 / 255, green: 253 / 255, blue: 253 / 255, alpha: 1.0)
        }
    }
    
    @objc func leftNavButtonClick(_ sender:UIButton!){
        self.navigationController?.popViewController(animated: true)
    }
    func setTitle(title:String){
        self.title = title
    }
}

extension UILabel {
    func setHTML(html: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '\(UIFont.systemFont(ofSize: 10, weight: .medium))'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, html.replacingOccurrences(of: "pre", with: "span")) as String

        guard let data = modifiedFont.data(using: .utf8) else { return  }
        do {
             self.attributedText = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
             self.attributedText =  NSAttributedString()
        }
    }
}

extension UITextView {
    func setHTML(html: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '\(UIFont.systemFont(ofSize: 10, weight: .medium))'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, html.replacingOccurrences(of: "pre", with: "span")) as String

        guard let data = modifiedFont.data(using: .utf8) else { return  }
        do {
             self.attributedText = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
             self.attributedText =  NSAttributedString()
        }
    }
    
    func adjustUITextViewHeight() -> CGFloat
    {
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        return newFrame.height
    }
}

extension UIButton{
    func alignVertical(spacing: CGFloat, lang: String) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
        else { return }

        let labelString = NSString(string: text)
        let titleSize = labelString.size(
            withAttributes: [NSAttributedString.Key.font: font]
        )

        var titleLeftInset: CGFloat = -imageSize.width
        var titleRigtInset: CGFloat = 0.0

        var imageLeftInset: CGFloat = 0.0
        var imageRightInset: CGFloat = -titleSize.width

        if Locale.current.languageCode! != "en" { // If not Left to Right language
            titleLeftInset = 0.0
            titleRigtInset = -imageSize.width

            imageLeftInset = -titleSize.width
            imageRightInset = 0.0
        }

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: titleLeftInset,
            bottom: -(imageSize.height + spacing),
            right: titleRigtInset
        )
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: imageLeftInset,
            bottom: 0.0,
            right: imageRightInset
        )
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
}

extension UserDefaults{
    enum Keys:String {
        case isRememberMe
    }
}

extension KeychainWrapper{
    enum Keys:String {
        case usernameKey
        case passwordKey
    }
}

extension Array where Element: UIImage {
      func makePDF()-> Data? {
        let pdfDocument = PDFDocument()
        for (index,image) in self.enumerated() {
            let imgData = image.jpeg(.medium) ?? Data()
            let img = UIImage(data: imgData) ?? UIImage()
            let pdfPage = PDFPage(image: img) ?? PDFPage()
            pdfDocument.insert(pdfPage, at: index)
        }
        return pdfDocument.dataRepresentation()
    }
}
