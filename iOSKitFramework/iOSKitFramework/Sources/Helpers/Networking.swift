//
//  Networking.swift
//  iOSKit
//
//  Created by iOS Developer on 1/8/18.
//  Copyright © 2018 Genysis. All rights reserved.
//


import UIKit
import Foundation
import SystemConfiguration

public enum DataType {
    case Image
    case Video
    case Audio
    case JSON
    case Image_With_JSON
}



public extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}



public extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}



public  typealias Parameters = [String:Any]

public class APIManager {
    
    
    static public let shared = APIManager()
    private init(){}
    
    public func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    public func getData(endPoint:String, completion:@escaping(Data?,Error?) -> Void) {
        print(endPoint)
        if isInternetAvailable() == true{
            DispatchQueue.global(qos: .userInitiated).async {
                guard let url = URL(string: "http://" + endPoint) else { return }
                URLSession.shared.dataTask(with: url) { (data, response
                    , error) in
                    if let data = data {
                        completion(data,nil)
                    } else {
                        completion(nil,"Error:\(String(describing: error?.localizedDescription.description ?? ""))" as? Error)
                    }
                    
                    }.resume()
            }
            
        } else {
            
            completion(nil,"Internet not connected.\nPlease connect to internet and try again." as? Error)
        }
    }
    
    
    public  func postData(endPoint:String,parameters:Parameters, dataType:DataType, filePath: String? = nil , image:UIImage? = nil ,completion:@escaping(Data?,Error?) -> Void) {
        
        if isInternetAvailable() == true {
            DispatchQueue.global(qos: .userInitiated).async {
                
                let headers = [
                    "content-type": "application/json",
                    ]
                let parameters = parameters
                
                let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
                
                let request = NSMutableURLRequest(url: NSURL(string:"http://" + endPoint)! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                
                
                if dataType == DataType.Image {
                    if let path = filePath, let imagename = image {
                        request.httpBody =  self.createRequestBodyWith(parameters:parameters, filePathKey:path, boundary:self.generateBoundaryString(), image: imagename) as Data
                    }
                    
                    
                } else if dataType == DataType.JSON {
                    request.httpBody = postData as Data
                }
                
                
                
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        completion(nil,"Error:\(String(describing: error))" as? Error)
                    } else {
                        completion(data!,nil)
                    }
                })
                
                dataTask.resume()
            }
            
        } else {
            completion(nil,"Internet not connected.\nPlease connect to internet and try again." as? Error)
        }
    }
    
  

    
    
}

fileprivate extension APIManager {
    
    
    private func createRequestBodyWith(parameters:Parameters, filePathKey:String, boundary:String, image: UIImage) -> NSData{
        
        let body = NSMutableData()
        
        for (key, value) in parameters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        
        let mimetype = "image/jpg"
        
        let randomName = UUID().uuidString
        let defFileName = "\(randomName).jpg"
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(defFileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData!)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
}


fileprivate extension NSMutableData {
    
    fileprivate  func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
    
    
}
