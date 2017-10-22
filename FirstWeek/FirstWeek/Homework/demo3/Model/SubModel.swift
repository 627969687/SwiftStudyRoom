//
//  LeafModel.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/22.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class SubModel: NSObject {
    var rootID = "" // 根ID
    var ownID = "" // 自身ID
    var info = "" // 内容
    var level = 0 // 等级
    var isOpen = false // 是否展开
    var isLeaf = false // 是否叶子
    
    class func node(rootID:String,ownID:String,info:String,level:Int,isOpen:Bool,isLeaf:Bool) -> SubModel {
        let model = SubModel()
        model.rootID = rootID
        model.ownID = ownID
        model.info = info
        model.level = level
        model.isOpen = isOpen
        model.isLeaf = isLeaf
        return model
    }
}
