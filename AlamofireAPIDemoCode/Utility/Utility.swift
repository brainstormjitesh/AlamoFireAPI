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
}
