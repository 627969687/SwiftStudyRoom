//
//  UIView-extension.swift
//  iOS_Swift_demo
//
//  Created by kuyou1 on 2017/6/14.
//  Copyright © 2017年 kuyou1. All rights reserved.
//

import UIKit

// MARK: - frame
extension UIView {
    func setX(x:CGFloat) {
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func setY(y:CGFloat) {
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func maxX() -> CGFloat {
        return self.frame.maxX
    }
    
    func maxY() -> CGFloat {
        return self.frame.maxY
    }
    
    func setCenterX(centerX:CGFloat) {
        var center = self.center
        center.x = centerX
        self.center = center
    }
    
    func centerX() -> CGFloat {
        return self.center.x
    }
    
    func setCenterY(centerY:CGFloat) {
        var center = self.center
        center.y = centerY
        self.center = center
    }
    
    func centerY() -> CGFloat {
        return self.center.y
    }
    
    func setWidth(width:CGFloat) {
        var bounds = self.bounds
        bounds.size.width = width
        self.bounds = bounds
    }
    
    func width() -> CGFloat {
        return self.bounds.size.width
    }
    
    func setHeight(height:CGFloat) {
        var bounds = self.bounds
        bounds.size.height = height
        self.bounds = bounds
    }
    
    func height() -> CGFloat {
        return self.bounds.size.height
    }
}
