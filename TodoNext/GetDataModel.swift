//
//  GetDataModel.swift
//  TodoNext
//
//  Created by Kalitha H N on 22/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class GetDataModel {
    var mDescription : String?
    var mUserId :String?
    var mTitle : String?
    var mCreatedTime : String?
    
    init(pDescription:String, pUserId:String, pTitle:String, pCreatedTime:String) {
        self.mTitle = pTitle
        self.mCreatedTime = pCreatedTime
        self.mDescription = pDescription
        self.mUserId = pUserId
    }
}
