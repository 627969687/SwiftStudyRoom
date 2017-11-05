//
//  SeafoodModel.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/4.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class SeafoodModel: NSObject {
    @objc var title = ""
    @objc var info = [[String:Any]]()

    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
