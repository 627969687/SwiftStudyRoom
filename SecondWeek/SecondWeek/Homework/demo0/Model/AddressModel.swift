//
//  AddressModel.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    @objc var avatar = ""
    @objc var Name = ""
    @objc var Mobile = ""
    @objc var Email = ""
    @objc var Notes = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
