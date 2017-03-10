//
//  GetDataService.swift
//  TodoNext
//
//  Created by Kalitha H N on 22/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit
import Alamofire
class GetDataService: NSObject {
    var mArrayOfGetDataModel = [GetDataModel]()
    
    var mTaskDetailsProtocolObj : TaskDetailsProtocol?
    
    init(pTaskDetailsProtocolObj : TaskDetailsProtocol) {
        mTaskDetailsProtocolObj = pTaskDetailsProtocolObj
    }
    
    func fetchData(){
        
        //        Alamofire.request("http://freejsonapis-showin.rhcloud.com/getNote?userid=ram@gmail.com", method: .get).responseJSON
        //            { response in
        //                print("value----",response.result.value!)
        //                if let JSON = response.result.value{
        //                    let completeData = JSON as! NSDictionary
        //                    print("---data in json----",completeData)
        //                    let array = completeData["list"] as! NSArray
        //                    for dictionary in array
        //                    {
        //                        //each employee record is in the form of the nsdictionary
        //                        let lDict1 = dictionary as! NSDictionary
        //                        //fetching all details of employee
        //                        let lUserId = lDict1["userid"] as! String
        //                        let lTitle = lDict1["title"] as! String
        //                        let lDesc = lDict1["data"] as! String
        //                        let lDate = lDict1["time"] as! String
        //                        let lSnNo = lDict1["sno"] as! Int
        //                        print("userId is \(lUserId)")
        //                        print("todoTitle is \(lTitle)")
        //                        print("todoDesc is \(lDesc)")
        //                        print("todoDate is \(lDate)")
        //                        print("userId is \(lSnNo)")
        //                        let todoList = GetDataModel(pSerialNo: lSnNo, pDescription: lDesc, pUserId: lUserId, pTitle: lTitle, pCreatedTime: lDate)
        //                        self.mArrayOfGetDataModel.append(todoList)
        //
        //                    }
        //self.mTaskDetailsProtocolObj?.fetchedData(pGetDataModel: mArrayOfGetDataModel)
        //                }
        //        }
        
        
        guard let url = URL(string: "http://freejsonapis-showin.rhcloud.com/getNote?userid=kalitha.gowda@gmail.com")else{
            print("Error in the url")
            return
        }
        let urlRequest = URLRequest(url: url)
        print(urlRequest)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            //            print("=-=-==error=-=-=-",error)
            //            print("-=-===response-=====",response)
            //            print("=-=-=data=-=-=-=",data)
            // check for any errors
            guard error == nil
                else
            {
                print("error while calling GET on data")
                print(error!)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("error=-=-=- \(httpResponse.statusCode)")
                
            }
            // make sure we got data
            guard let responseData = data
                else
            {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]
                    else
                {
                    print("error while trying to convert data to JSON")
                    return
                }
                // printing json data
                print("The To-DO Data is: " + json.description)
                
                //receiving in the form of the NSDictionary
                guard let todoData = json as? [String : AnyObject]
                else
                {
                    print("error while fetching the json data")
                    return
                }
                guard let array = todoData["list"] as? [AnyObject]
                    else{
                        print("error while fetching the array data")
                        return
                }
                
                for dictionary in array
                {
                    //each employee record is in the form of the nsdictionary
                    let dict = dictionary as! [String : AnyObject]
                    //fetching all details of employee
                    let lUserId = dict["userid"] as? String ?? ""
                    let lTitle = dict["title"] as? String ?? ""
                    let lDesc = dict["data"] as? String ?? ""
                    let lDate = dict["time"] as? String ?? ""
//                    let lSnNo = dict["sno"] as! Int
                    
                    print("userId is \(lUserId)")
                    print("todoTitle is \(lTitle)")
                    print("todoDesc is \(lDesc)")
                    print("todoDate is \(lDate)")
                    
                    let todoList = GetDataModel(pDescription: lDesc, pUserId: lUserId, pTitle: lTitle, pCreatedTime: lDate)
                    self.mArrayOfGetDataModel.append(todoList)
                }
                print("---count of tasks---",self.mArrayOfGetDataModel.count)
                    self.mTaskDetailsProtocolObj?.fetchedData(pGetDataModel: self.mArrayOfGetDataModel)

            }
            catch
            {
                print("error trying to convert data to JSON")
                return
            }
        })
        task.resume()
        
    }
}
