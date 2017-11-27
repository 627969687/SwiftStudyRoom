//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo1Controller: UIViewController {
    @IBOutlet weak var leftEyeV: UIView!
    @IBOutlet weak var rightEyeV: UIView!
    @IBOutlet weak var mouthV: UIView!
    @IBOutlet weak var msgLabel: UILabel!
    
    fileprivate var originMouthFrame: CGRect!
    fileprivate var originRightFrame: CGRect!
    fileprivate var originLeftFrame: CGRect!
    fileprivate var isAnimate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        originMouthFrame = mouthV.frame
        originLeftFrame = leftEyeV.frame
        originRightFrame = rightEyeV.frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isAnimate = true
        setupAnimation()
    }
}

// MARK: - UI
extension Demo1Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
    }
}

extension Demo1Controller {
    @IBAction func clean() {
        msgLabel.isHidden = true
        mouthV.frame = originMouthFrame
        leftEyeV.frame = originLeftFrame
        rightEyeV.frame = originRightFrame
    }
}

extension Demo1Controller {
    fileprivate func setupAnimation() {
        if isAnimate {
            clean()
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 1.0, options: .layoutSubviews, animations: {
            self.eyeAnimation()
            self.mouthAnimation()
        }) { (result) in
            self.msgLabel.isHidden = false
        }
        
    }
    
    fileprivate func eyeAnimation() {
        leftEyeV.setX(x: view.width() - leftEyeV.maxX())
        leftEyeV.setY(y: leftEyeV.y() + 50)
        
        rightEyeV.setX(x: view.width() - rightEyeV.maxX())
        rightEyeV.setY(y: rightEyeV.y() + 50)
    }
    
    fileprivate func mouthAnimation() {
        mouthV.setHeight(height: mouthV.height() * 5)
        mouthV.setY(y: mouthV.y() + 100)
    }
}




