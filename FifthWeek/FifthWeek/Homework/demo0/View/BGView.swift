//
//  BGView.swift
//  FifthWeek
//
//  Created by 荣 Jason on 2017/11/13.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class BGView: UIView {
    var progress:CGFloat = 0
    
    fileprivate let borderWH:CGFloat = 10
    fileprivate var bgCircle = CAShapeLayer()
    fileprivate var progressCircle = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBGCircle()
    }
    
    override func draw(_ rect: CGRect) {
        setupProgressCircle()
    }
}

extension BGView {
    fileprivate func setupBGCircle() {
        let path = UIBezierPath(ovalIn: CGRect(x: x()+borderWH/2, y: y()+borderWH/2, width: width()-borderWH, height: height()-borderWH))
        
        bgCircle.frame = frame
        bgCircle.path = path.cgPath
        bgCircle.lineWidth = borderWH
        bgCircle.fillColor = UIColor.clear.cgColor
        bgCircle.strokeColor = UIColor.lightGray.cgColor
        
        layer.addSublayer(bgCircle)
    }
    
    fileprivate func setupProgressCircle() {
        let cycleCenter = CGPoint(x: width() / 2, y: height() / 2)
        let radius = width() / 2 - 5
        let startPoint:CGFloat = .pi/2 * 3
        let endPoint:CGFloat = startPoint + .pi * 2 * progress
        let path = UIBezierPath(arcCenter: cycleCenter, radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        progressCircle = CAShapeLayer()
        progressCircle.frame = frame
        progressCircle.path = path.cgPath
        progressCircle.lineWidth = borderWH
        progressCircle.fillColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        progressCircle.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        layer.addSublayer(progressCircle)
    }
}
