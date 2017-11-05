//
//  FallModel.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/5.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class FallModel: NSObject {
    @objc var height:CGFloat = 0
    @objc var width:CGFloat = 0
    @objc var image = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
