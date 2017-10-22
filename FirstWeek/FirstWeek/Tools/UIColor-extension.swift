//
//  UIColor-extension.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/22.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgbColor(_ RGB : Double , A : CGFloat) ->UIColor {
        return UIColor(red: CGFloat(RGB/255.0), green: CGFloat(RGB/255.0), blue: CGFloat(RGB/255.0), alpha: A)
    }
}
