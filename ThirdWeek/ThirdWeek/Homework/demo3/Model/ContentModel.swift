//
//  ContentModel.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/4.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class ContentModel: NSObject {
    @objc var name = ""
    @objc var image = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
