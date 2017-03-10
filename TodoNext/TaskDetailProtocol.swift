//
//  TaskDetailProtocol.swift
//  TodoNext
//
//  Created by Kalitha H N on 22/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import Foundation

  protocol TaskDetailsProtocol
 {
        func fetchedData(pGetDataModel:[GetDataModel])
   // @objc optional func errorInformation(status :Int)
}

protocol HomePageVCProtocol {
    func tableViewReload()
}
