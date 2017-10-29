//
//  CardModel.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class CardModel: NSObject {
    @objc var title = ""
    @objc var img = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
