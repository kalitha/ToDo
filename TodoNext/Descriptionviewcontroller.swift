//
//  Descriptionviewcontroller.swift
//  TodoNext
//
//  Created by Kalitha H N on 24/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class Descriptionviewcontroller: UIViewController,TaskDetailsProtocol {
    
    @IBOutlet weak var mTitle: UITextField!
    @IBOutlet weak var mTextView: UITextView!
    var mPostDataServiceObj : PostDataService?
    var mGetDataModel : GetDataModel?
    var mHomePageVC : HomePageViewController?
    
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mActivityIndicator.stopAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(self.postIsSuccess), name: NSNotification.Name(rawValue: "postNotification"), object: nil)
    }
    func postIsSuccess(){
        DispatchQueue.main.async {
            self.mActivityIndicator.stopAnimating()
            self.mHomePageVC?.makeRestCall()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        mTextView.text = mGetDataModel?.mDescription
        mTitle.text = mGetDataModel?.mTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ocClick(_ sender: Any) {
        mActivityIndicator.isHidden = false
        mActivityIndicator.startAnimating()
        mGetDataModel?.mDescription = mTextView.text
        if( ReachabilityStatus.isInternetAvailable()) {
            mPostDataServiceObj = PostDataService(pTaskDetailsProtocolObj: self)
            
            print("=========================next    ")
            mPostDataServiceObj?.postData(userid: (mGetDataModel?.mUserId)!, title: (mGetDataModel?.mTitle)!, description: (mGetDataModel?.mDescription)!, createdTime: (mGetDataModel?.mCreatedTime)!)
        }
        else{
            savingInUserDefaults()
            
        }
    }
    
    func savingInUserDefaults(){
        
        if let str = UserDefaults.standard.value(forKey: "listOfData") as? String{
            
            let data = str.data(using: .utf8)
            
            let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            let listOfData = jsonObject as! [String : [Any]]
            
            var dict = [String:Any]()
            
            dict["data"] = mGetDataModel?.mDescription
            dict["userid"] = mGetDataModel?.mUserId
            dict["title"] = mGetDataModel?.mTitle
            dict["time"] = mGetDataModel?.mCreatedTime
            
//            let dict = [
//                "data":mGetDataModel?.mDescription,
//                "time":mGetDataModel?.mCreatedTime,
//                "title":mGetDataModel?.mTitle,
//                "userid":mGetDataModel?.mUserId
//            ]
            
            var dictArray : [Any] = listOfData["list"]!
            dictArray.append(dict)
            let dictionary = ["list":dictArray]
            print("=-=-dictionary=-=-=-",dictionary)
            
            print(JSONSerialization.isValidJSONObject(dictionary))
            
            if JSONSerialization.isValidJSONObject(dictionary){
                let jsonData = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                let storeString = String.init(data: jsonData, encoding: .utf8)
                
                UserDefaults.standard.set(storeString, forKey: "listOfData")
                print("storeString",storeString!)
                self.mHomePageVC?.addTaskOnOffline()
            }
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
        
        //-==============----------=================
        
    }
    
    
    func fetchedData(pGetDataModel:[GetDataModel])
    {
        
    }
}
