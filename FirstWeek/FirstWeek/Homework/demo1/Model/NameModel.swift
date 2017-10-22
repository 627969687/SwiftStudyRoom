//
//  NameModel.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class NameModel: NSObject {
    @objc var title = ""
    @objc var names = [String]()
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
