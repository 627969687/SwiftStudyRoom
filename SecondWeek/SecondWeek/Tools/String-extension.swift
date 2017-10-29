//
//  NSString-extension.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
    mutating func mobileFormat() -> String {
        var temp = 0
        for i in 1...(self.count / 4) {
            self.insert("-", at: self.prefix(i*4+temp).endIndex)
            temp = temp + 1
        }
        if self.last == "-" {
            let end = self.index(self.endIndex, offsetBy: -2)
            let range: Range<String.Index> = end..<self.endIndex
            self.replaceSubrange(range, with: "")
        }
        return self
    }
}

