//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo1Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - UI
extension Demo1Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        setupMusicBar()
    }
    
    fileprivate func setupMusicBar() {
        let layer = CALayer()
        layer.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        layer.frame = CGRect(x: 0, y: 100, width: 20, height: 100)
        addAnim(layer: layer)
        copyLayer(layer: layer)
    }
    
    fileprivate func addAnim(layer:CALayer) {
        let anim = CABasicAnimation(keyPath: "transform.scale.y")
        anim.fromValue = 0
        anim.duration = 0.25
        anim.repeatCount = MAXFLOAT
        anim.autoreverses = true
        layer.add(anim, forKey: nil)
    }
    
    fileprivate func copyLayer(layer:CALayer) {
        let copyLayer = CAReplicatorLayer()
        copyLayer.instanceCount = 6
        copyLayer.instanceDelay = 0.05
        copyLayer.instanceGreenOffset = -0.15
        copyLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0)
        copyLayer.addSublayer(layer)
        view.layer.addSublayer(copyLayer)
    }
}





