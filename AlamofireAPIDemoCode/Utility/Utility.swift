//
//  Utility.swift
//  AlamofireAPIDemoCode
//
//  Created by Brainstorm Jitesh on 21/07/18.
//  Copyright © 2018 Brainstorm Jitesh. All rights reserved.
//

import UIKit
import SVProgressHUD

class Utility: NSObject
{
    static let objUtility = Utility()
    override init() {

    }
    class func showLoader()
    {
        SVProgressHUD.show()
    }
    class func hideLoader()
    {
        SVProgressHUD.dismiss()
    }
    class func dicToJSON(dic: NSDictionary) -> String
    {
        var jsonString: String = ""
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            jsonString = String.init(data: jsonData, encoding: .utf8)!
        }
        catch
        {
            print(error.localizedDescription)
            jsonString = ""
        }
        return jsonString
    }
    
    class func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
   class func alertWith(_ title: String = "Demo", message: String, doneTitle:String? = "OK", cancelTitle:String? = "Cancel", doneAction:(()->())? = nil, cancelAction:(()->())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: doneTitle, style: .default, handler: { (action) in
            if doneAction != nil {
                doneAction!()
            }
        }))
        
        if cancelAction != nil {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
                cancelAction!()
            }))
        }
        
        DispatchQueue.main.async {
            AppDelegate.sharedDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
   class func errorAlert(_ title: String = "Demo", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        
        DispatchQueue.main.async {
            AppDelegate.sharedDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
   class func successAlert(_ title: String = "Demo", message: String, doneAction:(()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if doneAction != nil {
                doneAction!()
            }
        }))
        
        DispatchQueue.main.async {
            AppDelegate.sharedDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func convertDict(toJSON dict: NSMutableDictionary?) -> String? {
        var dict = dict
        var error: Error?
        var jsonString: String?
        var jsonData: Data? = nil
        if let aDict = dict {
            jsonData = try? JSONSerialization.data(withJSONObject: aDict, options:.prettyPrinted)
        }
        if jsonData != nil {
            if let aData = jsonData {
                jsonString = String(data: aData, encoding: .utf8) ?? ""
            }
            //This is your JSON String
            //NSUTF8StringEncoding encodes special characters using an escaping scheme
        } else {
            if let anError = error {
                print("Got an error: \(anError)")
            }
            jsonString = ""
        }
        print("Your JSON String is \(jsonString)")
        return jsonString
    }
    class func convertArray(toJSON array: NSMutableArray?) -> String? {
        var array = array
        var error: Error?
        var jsonString: String?
        var jsonData: Data? = nil
        if let anArray = array {
            jsonData = try? JSONSerialization.data(withJSONObject: anArray, options:         // Here you can pass array or dictionary
                .prettyPrinted)
        }
        if jsonData != nil {
            if let aData = jsonData {
                jsonString = String(data: aData, encoding: .utf8) ?? ""
            }
            //This is your JSON String
            //NSUTF8StringEncoding encodes special characters using an escaping scheme
        } else {
            if let anError = error {
                print("Got an error: \(anError)")
            }
            jsonString = ""
        }
        print("Your JSON String is \(jsonString)")
        return jsonString
    }
    class func dict(toJson dict: NSMutableDictionary?) -> String? {
        var dict = dict
        var err: Error?
        var jsonData: Data? = nil
        if let aDict = dict {
            jsonData = try? JSONSerialization.data(withJSONObject: aDict, options: [])
        }
        var myString: String? = nil
        if let aData = jsonData {
            myString = String(data: aData, encoding: .utf8)
        }
        return myString
    }
    class func randomString(withLength len: Int) -> String? {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = String(repeating: "\0", count: len)
        for i in 0..<len {
            randomString += "\(letters[letters.index(letters.startIndex, offsetBy: String.IndexDistance(arc4random_uniform(UInt32(letters.count))))])"
        }
        return randomString
    }
   

}
