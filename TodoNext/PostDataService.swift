//
//  PostDataService.swift
//  TodoNext
//
//  Created by Kalitha H N on 24/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class PostDataService{
    
    var mTaskDetailsProtocolObj : TaskDetailsProtocol?
    
    init(pTaskDetailsProtocolObj : TaskDetailsProtocol) {
        mTaskDetailsProtocolObj = pTaskDetailsProtocolObj
    }
    func postData(userid:String, title:String,description:String,createdTime:String){
        let userEmail = "kalitha.gowda@gmail.com"
        let params = ["note":description,"time":createdTime,"userid":userEmail, "title":title]
        let url = URL(string: "http://freejsonapis-showin.rhcloud.com/storeData?userid=kalitha.gowda@gmail.com")
        var urlRequest = URLRequest(url: url!)
        print(urlRequest)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
//        let str = String.init(data: data, encoding: .utf8)
//        print(str)
        
        urlRequest.httpBody = data
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: {data, response, error -> Void in
            
            if error != nil
            {
               // self.mTaskDetailsProtocolObj?.errorInformation!(status: 0)
            }
            print("Response: \(response)")
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "postNotification"), object: nil)
            }
            else {
              //  self.mTaskDetailsProtocolObj?.errorInformation!(status: (httpResponse?.statusCode)!)
            }
            
        })
        task.resume()
    }
}
