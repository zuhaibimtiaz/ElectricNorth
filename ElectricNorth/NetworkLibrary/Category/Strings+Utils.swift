import Foundation
import UIKit
public extension String{
    func stringByTrimingWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    func alphabeticString()-> String{
        var tempString = ""
        for ch in self.unicodeScalars{
            if (ch.value > 96 && ch.value < 123) || (ch.value > 64 && ch.value < 91){
                tempString.unicodeScalars.append(ch)
            }
        }
        return tempString
    }
    func matchWithRegularExpression(regx: String) -> Bool{
        if let _ = self.range(of: regx, options: NSString.CompareOptions.regularExpression){
            return true
        }
        else{
            return false
        }
        
    }
    
    func htmlEncodedString() -> String{
        if let str = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            return str
        }
        else{
            return self
        }
    }
    
    
    func toBool() -> Bool?
    {
        switch self
        {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toDateFormatted(with dateFormat:String)-> NSDate? {
        let formator = DateFormatter()
        formator.dateFormat = dateFormat
        return formator.date(from: self) as NSDate?
    }
    
    
    func containsWhiteSpace() -> Bool {
        
        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)
        
        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func isNumber() -> Bool {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func attributedStringWithColorChange(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat(99999), height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
public extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext() //as CGContextRef
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0);
        context!.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x:0, y:0, width:self.size.width, height:self.size.height) as CGRect
        context!.clip(to: rect, mask: self.cgImage!)
        context!.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension Dictionary where Value: Comparable {
    var valueKeySorted: [(Key, Value)] {
        return sorted{ $0.1 > $1.1 }.sorted{ String(describing: $0.0) < String(describing: $1.0) }
    }
    // or sorting as suggested by Just Another Coder without using map
    var valueKeySorted2: [(Key, Value)] {
        return sorted{ if $0.1 != $1.1 { return $0.1 > $1.1 } else { return String(describing: $0.0) < String(describing: $1.0) } }
    }
    
    
}

extension UILabel{
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.frame.width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}
extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        var isLess = false
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        var isEqualTo = false
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
}
extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}
//extension String{
//  func aesEncrypt() throws -> String {
//    let encrypted = try AES(key: "keykeykeykeykeykkeykeykeykeykeyk", iv: "1234567890123456", padding: .zeroPadding).encrypt([UInt8](self.data(using: .utf8)!))
//    return Data(encrypted).base64EncodedString()
//  }
//  func aesDecrypt() throws -> String {
//    guard let data = Data(base64Encoded: self) else { return "" }
//    let decrypted = try AES(key: "keykeykeykeykeykkeykeykeykeykeyk", iv: "1234567890123456", padding: .zeroPadding).decrypt([UInt8](data))
//    return String(bytes: decrypted, encoding: .utf8) ?? self
//  }
//}
extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

