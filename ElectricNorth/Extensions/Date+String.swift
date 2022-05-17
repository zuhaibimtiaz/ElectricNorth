
import Foundation
import UIKit

enum DateFormateStyle {
  case custom(String)
  case MMddyyyHHmmssaWithSlash, MMMddyyyyWithSlash, MMddyyyyWithSlash, TIME_FORMAT, TIME_DATE_FORMAT, DATE_TIME_FORMAT_ISO8601

  var value: String {
    switch self {
    case .MMddyyyHHmmssaWithSlash:
        return "MM/dd/yyyy, h:mm:ss a"
    case .MMMddyyyyWithSlash:
      return "MMM/dd/yyyy"
    case .MMddyyyyWithSlash:
      return "MM/dd/yyyy"
    case .TIME_FORMAT:
      return "h:mm a"
    case .TIME_DATE_FORMAT:
      return "h:mm a MM/dd/yyyy"
    case .DATE_TIME_FORMAT_ISO8601:
      return "yyyy-MM-dd'T'HH:mm:ss"
    case .custom(let customValue):
      return customValue
    }
  }
}

extension Date {
    
    func string(with format: DateFormateStyle) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.value
        return formatter.string(from: self)
    }
    
    func getOnlyDate() -> Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date1 = Calendar.current.date(from: dateComponents)
        return date1 ?? Date()
    }
    
    func days(from date: Date) -> Int {
        let dateComponents = Calendar.current.dateComponents([.day], from: date, to: self)
        return abs(dateComponents.day ?? 0)
    }
}

extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}

extension String {
    func date(with format: DateFormateStyle) -> Date? {
        let dateComponentsArray = self.components(separatedBy: ".")
        let dateOnlywithtime: String = dateComponentsArray[0]
        let formatter = DateFormatter()
        formatter.dateFormat = format.value
        return formatter.date(from: dateOnlywithtime)
    }
    func timeConversion12() -> String {
        let dateAsString = self
        let df = DateFormatter()
        df.dateFormat = "HH:mm"

        let date = df.date(from: dateAsString)
        df.dateFormat = "hh:mm a"

        let time12 = df.string(from: date!)
        print(time12)
        return time12
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            for string in strings {
                let range = (self as NSString).range(of: string)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], range: range)
            }

            guard let characterSpacing = characterSpacing else {return attributedString}

            attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

            return attributedString
        }
    
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

}
