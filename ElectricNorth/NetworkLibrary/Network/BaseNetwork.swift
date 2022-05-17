import Foundation
import UIKit

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}

class BaseNetwork {
    private func configurePostRequest( request:inout NSMutableURLRequest,requestMessage:NetworkRequestMessage){
        request.httpMethod = "POST"
        
        if(requestMessage.contentType == ContentType.JSON){
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestMessage.params, options: .prettyPrinted)
                request.httpBody = jsonData
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
            }
        }else if requestMessage.contentType == ContentType.HTML {
            
            var queryString = ""
            
            for (key,value) in requestMessage.params {
                let valueString = "\(value)".htmlEncodedString()
                queryString = "\(queryString)\(key)=\(valueString)&"
            }
            
            print("----- POST Request -----")
            print("URL : \(String(describing: request.url))")
            print("Query String : \(queryString)")
            print("----- POST Request -----")
            request.httpBody = queryString.data(using: String.Encoding.utf8)
        }
        
    }
    
    private func configureGetRequest(request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        request.httpMethod = "GET"
        
        let queryString = ""
        print(queryString)
        
        if let reallyURL = NSURL(string: requestMessage.url ){//+ "?" + queryString){
            request.url = reallyURL as URL
        }
        else{
            
        }
        
        print("----- GET Request -----")
        print("URL : \(String(describing: request.url))")
        print("Query String : \(queryString)")
        print("----- GET Request -----")
    }
    
    private func configureRequest (request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        switch requestMessage.requestType {
        
        case RequestType.GET:
            
            self.configureGetRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.POST:
            
            self.configurePostRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.PUT:
            
            request.httpMethod = "PUT"
            
        case RequestType.DELETE:
            
            request.httpMethod = "DELETE"
            
        case RequestType.HEAD:
            
            request.httpMethod = "HEAD"
            
        case RequestType.OPTIONS:
            
            request.httpMethod = "OPTIONS"
            
        }
    }
    private func addCustomHeaders(request:inout NSMutableURLRequest){
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // request.addValue(Global.shared.API_TOKEN, forHTTPHeaderField: "Authorization")
        
    }
    private  func addTokenHeader (request:inout NSMutableURLRequest){          
        request.addValue("Bearer \(Global.shared.headerToken)", forHTTPHeaderField: "Authorization")
    }

    //MARK: - For Network Operation request
    fileprivate func performNetworkOperation(_ request: NSMutableURLRequest, _ responseMessage: NetworkResponseMessage, _ complete: @escaping ((NetworkResponseMessage) -> Void)) {

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (incomingData, response, error) in
            
            if let err = error{
                if err.localizedDescription.contains("timed out"){
                    responseMessage.statusCode = StatusCode.Timeout
                }else{
                    responseMessage.statusCode = StatusCode.Failure
                }
                responseMessage.message = err.localizedDescription
            }else if let incomingData = incomingData {
                let responseInStringFormat : String = String(data: incomingData, encoding: String.Encoding.utf8)!
                print("----- Response -----")
                print("\(responseInStringFormat)")
                print("----- Response -----")
                
                responseMessage.statusCode = StatusCode.Success
                responseMessage.message = "Success"
                responseMessage.data = incomingData as AnyObject?
            }
            
            complete(responseMessage)
            
        })
        task.resume()
    }
    
    //MARK: - For Get and Post Request
    func performNetworkTask(isToken:Bool,requestMessage : NetworkRequestMessage, complete: @escaping ((_ responseMessage: NetworkResponseMessage)->Void)) {
        
        let responseMessage = NetworkResponseMessage()
        
        if let reallyURL = NSURL(string: requestMessage.url){
            
            var request = NSMutableURLRequest(url: reallyURL as URL)
            if isToken{
                self.addTokenHeader(request: &request)
            }
            print("URL: ", requestMessage.url)
            print("Request Params: ", convertStringFromJsonObject(requestMessage.params))
            self.configureRequest(request: &request, requestMessage: requestMessage)
            self.performNetworkOperation(request, responseMessage, complete)
        }
    }
    
    //MARK: - perform Multipart Request
    func performUploadMultipartTask(isToken:Bool,requestMessage: NetworkRequestMessage, media:[MediaAttachment]?, complete: @escaping ((_ responseMessage: NetworkResponseMessage)->Void))  {
        if let url = URL(string: requestMessage.url){
            let responseMessage = NetworkResponseMessage()
            print("URL: ", requestMessage.url)
            print("Request Params: ", convertStringFromJsonObject(requestMessage.params))
            var request = NSMutableURLRequest(url: url)
            if isToken{
                self.addTokenHeader(request: &request)
            }
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let boundary = self.generateBoundaryString()
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let dataBody = self.createMultipartDataBody(withParameters: requestMessage.params, media: media, boundary: boundary)
            request.httpBody = dataBody
            
            self.performNetworkOperation(request, responseMessage, complete)
        }
        
    }
    
    func createMultipartDataBody(withParameters params:[String:Any]?, media:[MediaAttachment]?, boundary: String ) -> Data{
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params{
            for (key, value) in parameters{
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }
        
        if let media = media{
            for photo in media{
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.parameterName)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    @objc func convertStringFromJsonObject(_ object: Any) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: .init(rawValue: 0))
            if let dataStr = String.init(data: jsonData, encoding: .utf8) {
                return dataStr
            }
        }
        catch (let error) {
            print(error)
        }
        
        return "[]"
    }
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}


