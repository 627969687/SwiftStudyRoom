//
//  HomeworkModel.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class HomeworkModel: NSObject {
    // swift4.0后要加@objc,不然会setValueUndeadFindKey
    @objc var project = ""
    
    // MARK: 自定义构造函数
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
