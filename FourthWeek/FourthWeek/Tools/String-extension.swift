//
//  NSString-extension.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit


// MARK: - 字符串尺寸
extension String {
    /// 计算字符串高度
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - font: 字体
    /// - Returns: 高度
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
}

// MARK: - 手机号码格式化
extension String {
    /// 手机号码格式化
    ///
    /// - Parameters:
    ///   - index: 索引
    ///   - tag: 标识
    /// - Returns: 格式化后字符串
    mutating func mobileFormat(_ index:Int = 4,_ tag:String = "-") -> String {
        var temp = 0
        for i in 1...(self.count / index) {
            self.insert("-", at: self.prefix(i*index+temp).endIndex)
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

extension String {
    /// 获取指定字符第一次出现在父字符串中的位置
    ///
    /// - Parameters:
    ///   - str: 字符
    ///   - isLower: 是否lowerBound（lowerBound：指定字符的第一个字符的位置，upperBound：指定字符的最后一个字符的位置+1）
    /// - Returns: 位置
    func positionOf(str:String,_ isLower:Bool=true) -> Int? {
        guard let range = range(of: str) else { return nil }
        if range.isEmpty { return nil }
        let to = isLower == true ? range.lowerBound : range.upperBound
        return characters.distance(from: startIndex, to: to)
    }
}

// MARK: - 截取
extension String {
    /**
     String(str[..<index]) ==> str.substring(to: index)
     String(str[index...]) ==> str.substring(from: index)
     String(str[range]) ==> str.substring(with: range)
     */
    
    /// 从指定字符串后开始截取
    ///
    /// - Parameter str: 指定字符串
    /// - Returns: 截取后的字符串
    func substringFrom(_ str:String) -> String? {
        guard let range = range(of: str) else { return nil }
        return String(self[range.upperBound...])
    }

    func substringTo(_ str:String) -> String? {
        guard let range = range(of: str) else { return nil }
        return String(self[..<range.upperBound])
    }
    
    func substringWith(_ str:String) -> String? {
        guard let range = range(of: str) else { return nil }
        return String(self[range])
    }
}
