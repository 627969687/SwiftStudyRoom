//
//  ContinentModel.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/22.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class RootModel: NSObject {
    var id = ""
    var info = "" // 内容
    var isOpen = false // 是否展开
    var subNodes:[SubModel] = [] // 子节点
    
    class func node(id:String,info:String) -> RootModel {
        let model = RootModel()
        model.id = id
        model.info = info
        return model
    }
}
