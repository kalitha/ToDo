//
//  HomePageViewModel.swift
//  TodoNext
//
//  Created by Kalitha H N on 22/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class HomePageViewModel:TaskDetailsProtocol {

    var mGetDataServiceObj : GetDataService?
    var mHomePageVCProtocolObj : HomePageVCProtocol?
    var mArrayOfGetDataModel = [GetDataModel]()
    var mCount = 0
    init(pHomePageVCProtocolObj : HomePageVCProtocol) {
        mHomePageVCProtocolObj = pHomePageVCProtocolObj
    }
    
    func fetchDataFromController()->Int{
        mGetDataServiceObj = GetDataService(pTaskDetailsProtocolObj: self)
        if(mArrayOfGetDataModel.count == 0){
            if(mCount == 0){
                fetchData()
                //offlineStoring()
           mCount += 1
            }
        }
        print("mArrayOfGetDataModel.count=-=--",mArrayOfGetDataModel.count)
        return mArrayOfGetDataModel.count
    }
    func fetchData(){
        mGetDataServiceObj?.fetchData()
    }
    
    func offlineTasksDisplay(){
        if(mArrayOfGetDataModel.count == 0){
            if(mCount == 0){
            offlineStoring()
                mCount += 1
            }
    }
 }
    
    func fetchedData(pGetDataModel:[GetDataModel]){
        mArrayOfGetDataModel.removeAll()
        print("mArrayOfGetDataModel.count before=-=-=",mArrayOfGetDataModel.count)
        mArrayOfGetDataModel = pGetDataModel
        print("mArrayOfGetDataModel.count afterv=-=-=",mArrayOfGetDataModel.count)
        self.mHomePageVCProtocolObj?.tableViewReload()
    }
    
    func offlineStoring(){
        if let str = UserDefaults.standard.value(forKey: "listOfData") as? String{
            
            mArrayOfGetDataModel = [GetDataModel]()
            let data = str.data(using: .utf8)
            
            let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            let listOfData = jsonObject as! [String : [Any]]
            
            
            if let  array = listOfData["list"]{
            
                for i in array{
                    
                    let k = i as! [String :String]
//                    print(k["data"])
//                    print(k["time"])
//                    print(k["title"])
//                    print(k["userid"])
                   let data = k["data"]
                    let time = k["time"]
                    let title = k["title"]
                    let userid = k["userid"]
                    
                 let model = GetDataModel(pDescription: data!, pUserId: userid!, pTitle: title!, pCreatedTime: time!)
                    mArrayOfGetDataModel.append(model)
                    
                }          
            }
            
        }
        self.mHomePageVCProtocolObj?.tableViewReload()
    }
}
