
import Foundation

class Global {
    
    class var shared : Global {
        struct Static {
            static let instance : Global  = Global()
        }
        return Static.instance
    }
    var headerToken = ""
    var fcmToken: String = ""
    var userModel = UserModel()
}
