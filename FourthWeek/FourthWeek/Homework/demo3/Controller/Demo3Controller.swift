//
//  Demo3Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo3Controller: UIViewController {
    let contentV = UIImageView(image: #imageLiteral(resourceName: "twitter"))
    // 遮罩
    lazy var maskLayer: CALayer = {
        let temp = CALayer()
        temp.contents = #imageLiteral(resourceName: "twitter logo mask").cgImage
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimate()
    }
}

extension Demo3Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.rgbColor(r: 76, g: 157, b: 232)
        contentV.frame = view.bounds
        view.addSubview(contentV)
        
        setupMask()
    }
    
    // 设置遮罩
    fileprivate func setupMask() {
        maskLayer.position = view.center
        maskLayer.bounds = CGRect(x: 0, y: 0, width: 120, height: 93)
        contentV.layer.mask = maskLayer
    }
}

// MARK: - 帧动画
extension Demo3Controller {
    fileprivate func setupAnimate() {
        let startScale:CGFloat = 0.5
        let endScale:CGFloat = view.height() / maskLayer.bounds.height > view.width() / maskLayer.bounds.width ? view.height() / maskLayer.bounds.height * 3 : view.width() / maskLayer.bounds.width * 3
        let startSize = CGSize(width: maskLayer.bounds.width * startScale, height: maskLayer.bounds.height * startScale)
        let endSize = CGSize(width: maskLayer.bounds.width * endScale, height: maskLayer.bounds.height * endScale)
        
        let animate = CAKeyframeAnimation(keyPath: "bounds")
        animate.delegate = self
        animate.duration = 2
        // CACurrentMediaTime是手机从开机一直到当前所经过的秒数
        animate.beginTime = CACurrentMediaTime() + 0.5
        
        let begin = contentV.layer.mask!.bounds
        let middle = CGRect(origin: CGPoint.zero, size: startSize)
        let end = CGRect(origin: CGPoint.zero, size: endSize)
        
        animate.values = [begin,middle,end]
        // 动画时间节点
        animate.keyTimes = [0,0.2,1]
        // 动画动几次就设置几个时间函数
        animate.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        contentV.layer.mask?.add(animate, forKey: nil)
    }
}

extension Demo3Controller:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("动画结束")
    }
}


