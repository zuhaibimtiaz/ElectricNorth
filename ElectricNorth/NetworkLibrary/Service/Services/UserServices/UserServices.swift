//
//  UserServices.swift
//  Trough
//
//  Created by Irfan Malik on 17/12/2020.
//

import Foundation
class UserServices: BaseService {
    //LOGIN USER
//    func userLoginRequest(params : [String : Any], complete : @escaping(( _ serviceResponse : ServiceResponseMessage)->Void)){
//        let url = API.USER_LOGIN_URL
//        guard BReachability.isConnectedToNetwork() else
//        {
//            let response = self.getInternetErrorResponseMessage(nil)
//            complete(response)
//            return
//        }
//
//        let networkRequestMessage = NetworkRequestMessage.init(requestType: .POST, contentType: .JSON, url: url, params: params as Dictionary<String,AnyObject>)
//        BaseNetwork().performNetworkTask(isToken: false, requestMessage: networkRequestMessage) { (networkResponseMessage) in
//            switch networkResponseMessage.statusCode {
//            case .Success :
//                do {
//                    let user = try JSONDecoder().decode(UserResponseViewModel.self , from: networkResponseMessage.data as! Data)
//                    if user.resultType == true {
//                        let response = self.getSuccessResponseMessage()
//                        response.message = user.message ?? ""
//                        response.data = user.data
//                        complete(response)
//                    }
//                    else {
//                        let response = self.getErrorResponseMessage(FAILED_MESSAGE as AnyObject)
//                        response.message = user.message ?? ""
//                        complete(response)
//                    }
//                }catch _ {
//                    let response = self.getErrorResponseMessage(FAILED_MESSAGE as AnyObject)
//                    complete(response)
//                }
//            case .Failure :
//                let response = self.getErrorResponseMessage(FAILED_MESSAGE as AnyObject)
//                complete(response)
//            case .Timeout :
//                let response = self.getTimeoutErrorResponseMessage("Request Timeout" as AnyObject)
//                complete(response)
//            }
//        }
//    }
}
