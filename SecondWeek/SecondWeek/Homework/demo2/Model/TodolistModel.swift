//
//  TodolistModel.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class TodolistModel: NSObject {
    @objc var info = ""
    @objc var date = ""
    @objc var icon = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
