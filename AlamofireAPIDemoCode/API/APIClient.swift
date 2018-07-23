//
//  API-Client.swift
//  API-Client Demo
//
//  Created by Brainstorm on 02/06/18.
//  Copyright © 2018 Brainstorm. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIClient: NSObject
{
    //let custObj: customClassViewController = customClassViewController()
    static let sharedInstance = APIClient()
    var session: URLSession
    var dataTask: URLSessionDataTask?
    //var manager: AFHTTPSessionManager!
    override init()
    {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
//            UserDefaults.standard.setValue(API_MAIN_URL, forKey: "baseUrl")
//            UserDefaults.standard.synchronize()
//            manager = AFHTTPSessionManager(baseURL: URL(string: API_MAIN_URL))
//            manager?.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            manager?.responseSerializer = AFJSONResponseSerializer(readingOptions: .allowFragments)
//            manager?.responseSerializer.acceptableContentTypes = Set(["application/json", "text/json", "text/javascript", "text/html", "text/plain"])
            //   manager?.requestSerializer.setValue("text/html", forHTTPHeaderField: "content-type")
            //manager?.responseSerializer.setValue("", forKey: "")
            //        manager?.securityPolicy.allowInvalidCertificates = true
            //        manager?.securityPolicy.validatesDomainName = false
            //manager?.requestSerializer = AFJSONRequestSerializer()
            //manager?.responseSerializer = AFJSONResponseSerializer()
        
        super.init()
    }
    
    func callAPI(strUrl: String, method : String, parameter: NSDictionary, completion: @escaping (NSDictionary?, Int, Error?) -> Void)
    {
        let apiURL : URL = URL.init(string: String.init(format: "%@",strUrl))!
        let request : NSMutableURLRequest = NSMutableURLRequest.init(url: apiURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let strData : String = Utility.dicToJSON(dic: parameter)
        request.httpBody = strData.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            if(error == nil)
            {
                if(data != nil)
                {
                    do
                    {
                        //print((response as! HTTPURLResponse).statusCode)
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        let dict : NSMutableDictionary = NSMutableDictionary.init(dictionary: json as! NSDictionary)
                        print(dict)
                        completion(dict, (response as! HTTPURLResponse).statusCode, nil)
                    }
                    catch let error
                    {
                        print(error)
                        DispatchQueue.main.async
                        {
                            completion(nil, (response as! HTTPURLResponse).statusCode , error)
                        }
                    }
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    /*let dict : NSMutableDictionary = NSMutableDictionary()
                    dict.setObject("0", forKey: "ReturnCode" as NSCopying)
                    dict.setObject(error?.localizedDescription ?? "Fail to load, Please try again", forKey: "ReturnMsg" as NSCopying)*/
                    
                    completion(nil,0, error)
                }
            }
        })
        
        task.resume()
    }
    
    func callAPIUploadImage(strUrl: String, parameter: NSDictionary, imageData : NSData, parameterName : String, fileName : String, mimeType : String, completion: @escaping (NSDictionary?, Int, Error?) -> Void)
    {
        let apiURL : URL = URL.init(string: String.init(format: "%@",strUrl))!
        let request : NSMutableURLRequest = NSMutableURLRequest.init(url: apiURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
        request.httpMethod = "POST"
        
        let boundary = Utility.generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
       
        for (key, value) in parameter
        {
            print(key)
            print(value)
            
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"\(key)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"\(parameterName)\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imageData as Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        print(body)
        let task =  session.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, response, error) -> Void in
            if let error = error
            {
                completion(nil, 0, error) // replaced 0 with (response as! HTTPURLResponse).statusCode
                print("Something went wrong: \(error)")
            }
            
            if data != nil
            {
                print("Response: \n \(response)")
                var dictRes:NSDictionary = NSDictionary()
                do
                {
                    dictRes = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
                    
                    print("parsedData Data = \(dictRes)")
                    
                    if dictRes.count > 0
                    {
                        completion(dictRes,(response as! HTTPURLResponse).statusCode, error)
                    }
                }
                catch let error as NSError
                {
                    completion(nil,(response as! HTTPURLResponse).statusCode, error)
                }
                
            }
        })
        
        task.resume()
    }
    
    
    func uploadImage(strUrl: String, parameter: NSDictionary, imageData : NSData, parameterName : String, fileName : String, mimeType : String, success: ((NSDictionary) -> Void)?, error: ((NSError) -> Void)?)
    {
        let apiURL : URL = URL.init(string: String.init(format: "%@",strUrl))!
        let request : NSMutableURLRequest = NSMutableURLRequest.init(url: apiURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
        request.httpMethod = "POST"
        
        let boundary = Utility.generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        if parameter != nil
        {
            for (key, value) in parameter
            {
                print(key)
                print(value)

                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition:form-data; name=\"\(key)\"\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"\(parameterName)\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imageData as Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
            {
            (data, response, error) -> Void in
                if let error = error
                {
                    print("Something went wrong: \(error)")
                }
                
                if data != nil
                {
                    print("Response: \n \(response)")
                    var dictRes:NSDictionary = NSDictionary()
                    do
                    {
                        dictRes = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary

                        print("parsedData Data = \(dictRes)")

                        if dictRes.count > 0
                        {
                            success!(dictRes)
                        }
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }

                }
        })
        
        task.resume()
    }
    
    public static func callApiPostWithImage(strUrl: String, parameter: NSDictionary, imageData : NSData, parameterName : String, fileName : String, mimeType : String, success: ((NSDictionary) -> Void)?, error: ((NSError) -> Void)?)
    {
        //let custObj: customClassViewController = customClassViewController()
//        if custObj.checkInternet() == false
//        {
//
//        }
//        manager?.post(strUrl, parameters: parameter, constructingBodyWith: {(formData: AFMultipartFormData?) -> Void in
//            formData?.appendPart(withFileData: imageData as Data!, name: parameterName, fileName: fileName, mimeType: mimeType)
//        }, success: { (op, response) -> Void in
//            
//            let dict: NSDictionary!
//            dict = response as! NSDictionary
//            success? (dict)
//        },failure: { (op, fault) -> Void in
//            print(fault ?? 0)
//            SVProgressHUD.dismiss()
//        })
//        
    }
    func apiCallAlamorPOST(Url:String,parameters: [String : Any], completionHandler: @escaping (_ Dic: NSDictionary?,_ status:Error?) -> Void)
    {
        //        let headers = ["Authorization" : "Bearer "+accessToken!+"",
        //                       "Content-Type": "application/json"]
        Alamofire.request(Url,method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON
            { (response:DataResponse) in
                switch(response.result)
                {
                case .success:
                    completionHandler(response.result.value!  as? NSDictionary, response.result.error!)
                case .failure:
                    completionHandler(response.result.value!  as? NSDictionary, response.result.error!)
                    break
                }
                
        }
    }
}
