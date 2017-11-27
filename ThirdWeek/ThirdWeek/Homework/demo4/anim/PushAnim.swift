//
//  PushAnim.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/18.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class PushAnim: NSObject,UIViewControllerAnimatedTransitioning {
    fileprivate var transitionContext:UIViewControllerContextTransitioning!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        // 获取来源/目标控制器
        guard let fromVC = transitionContext.viewController(forKey: .from) as? Demo4Controller else {return}
        guard let toVC = transitionContext.viewController(forKey: .to) as? TransitionController else {return}
        
        let fromFrame = fromVC.selectedCell.imageView.frame
        let toFrame = CGRect(x: 0, y: fromVC.view.safeAreaInsets.top, width: screenW, height: screenH - fromVC.view.safeAreaInsets.top - fromVC.view.safeAreaInsets.bottom)
        
        let contentView = transitionContext.containerView // 转场动画容器视图
        
        // 让被点击的cell的截图作为动画视图并设置截图在容器中的frame
        guard let animView = fromVC.selectedCell.imageView.snapshotView(afterScreenUpdates: false) else {return}
        // 动画frame = selectedCell的imageView相对于容器中的位置
        animView.frame = contentView.convert(fromFrame, from: fromVC.selectedCell)
        toVC.view.alpha = 0
        toVC.imageView.isHidden = true
        
        contentView.addSubview(toVC.view)
        contentView.addSubview(animView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            animView.frame = toFrame
            toVC.view.alpha = 1
        }) { (complete) in
            toVC.imageView.isHidden = false
            animView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

























// MARK: - 核心动画实现测试
extension PushAnim {
    fileprivate func animTest() {
//        // 做动画的内容视图
//        let contentView = transitionContext.containerView
//        contentView.addSubview(fromVC.view)
//        contentView.addSubview(toVC.view)
//        // mask和动画的配合
//        let fromPath = UIBezierPath(rect: fromFrame)
//        let toPath = UIBezierPath(rect: toFrame)
//
//        let animLayer = CAShapeLayer()
//        animLayer.path = toPath.cgPath
//        toVC.imageView.layer.mask = animLayer
//
//        let anim = CABasicAnimation(keyPath: "path")
//        anim.fromValue = fromPath.cgPath
//        anim.toValue = toPath.cgPath
//        anim.duration = transitionDuration(using: transitionContext)
//        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        anim.delegate = self
//        animLayer.add(anim, forKey: nil)
    }
}

extension PushAnim:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext.completeTransition(true)
        transitionContext.view(forKey: .from)?.mask = nil
        transitionContext.view(forKey: .to)?.mask = nil
    }
}
