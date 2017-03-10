//
//  Utility.swift
//  TodoNext
//
//  Created by Kalitha H N on 24/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class Utility{
let mFormatter = DateFormatter()
let mCurrentDate = Date()
 var mHomePageViewModelObj : HomePageViewModel?
    
    func date(date:String)->String{
        
        let lDate = Date.init(timeIntervalSince1970:Double(date)!)
        print("date",lDate)
        // initialize the date formatter and set the style
        mFormatter.dateFormat = "dd-MM-yyyy, HH:mm:ss"
       // mFormatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = mFormatter.string(from: lDate)
        
        return convertedDate
    }
    func currentDate() -> String {
        // initialize the date formatter and set the style
        
        mFormatter.dateFormat = "dd MM yyyy, HH:mm:ss"
        // get the date time String from the date object
        let convertedDate = mFormatter.string(from: mCurrentDate)
        
        return convertedDate
    }
}
