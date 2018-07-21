//
//  ViewController.swift
//  AlamofireAPIDemoCode
//
//  Created by Brainstorm Jitesh on 21/07/18.
//  Copyright © 2018 Brainstorm Jitesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func callUploadImagePdf()
//    {
//        if custObj.checkInternet() == false
//        {
//            return
//        }
//        custObj.showSVHud("Loading")
//        
//        let parameter: NSMutableDictionary = NSMutableDictionary()
//        parameter.setObject(APIKey, forKey: "Token" as NSCopying)
//        parameter.setObject(API.stringValueFromDictionary(dic: API.getLoggedUserData(), key: "UserID"), forKey: "UserID" as NSCopying)
//        print(parameter)
//        let dataToSend : NSData = UIImageJPEGRepresentation(self.imgUploadImage.image!, 0.5)! as NSData
//        let fileName : String = self.strImageName
//        let mimeType : String = "image/jpg"
//        let apiURL : String = String.init(format: "%@%@",API_MAIN_URL,API_AddProfilePicture)
//        
//        API.callApiPostWithImage(strUrl: apiURL, parameter: parameter, imageData: dataToSend, parameterName : "ImageData", fileName: fileName, mimeType: mimeType, success: { (response) in
//            print(response)
//            self.custObj.hideSVHud()
//            if response.object(forKey: "ReturnCode") as! String == "1"
//            {
//                //self.callAPIUpdateProfile()
//                self.alertWith(message: response.object(forKey: "ReturnMsg") as! String)
//                
//                let dictToUpdate : NSMutableDictionary = NSMutableDictionary.init(dictionary: API.getLoggedUserData())
//                dictToUpdate.setObject(response.object(forKey: "ReturnValue") as! String, forKey: "ProfileURL" as NSCopying)
//                API.setLoggedUserData(dict: dictToUpdate)
//                
//            }
//            else
//            {
//                self.alertWith(message:(response.object(forKey: "ReturnMsg") as! String))
//            }
//            
//        }, error: { (error) in
//            print(error)
//            self.alertWith(message:error.localizedDescription)
//            self.custObj.hideSVHud()
//        })
//        
//    }
    
//    func callAPIPromotePost()
//    {
//        if custObj.checkInternet() == false
//        {
//            return
//        }
//        // custObj.showSVHud("")
//        let parameter: NSMutableDictionary = NSMutableDictionary()
//        parameter.setObject(PostID, forKey: "PostID" as NSCopying)
//        print(parameter)
//        let apiURL : String = String.init(format: "%@%@", API_MAIN_URL, API_PromotePost)
//        APIClient.sharedInstance.callAPI(strUrl: apiURL, method : API_POST, parameter: parameter, completion: { data , status , error in
//            self.custObj.hideSVHud()
//            if error == nil
//            {
//                if(data != nil)
//                {
//                    let dict : NSMutableDictionary = NSMutableDictionary.init(dictionary: data! as NSDictionary)
//                    print(dict)
//                    if dict.object(forKey: "ReturnCode") as! String == "1"
//                    {
//                        DispatchQueue.main.async {
//
//                        }
//                    }
//                    else
//                    {
//                        DispatchQueue.main.async{
//                        }
//                    }
//                }
//            }
//            else
//            {
//                DispatchQueue.main.async{
//                    self.alertWith(message: (error?.localizedDescription)!)
//                }
//            }
//        })
//    }

}

