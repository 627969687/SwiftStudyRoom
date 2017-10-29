//
//  AddressModel.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/28.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class AddressGroupModel: NSObject {
    @objc var title = ""
    @objc var info = [[String:Any]]()
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
