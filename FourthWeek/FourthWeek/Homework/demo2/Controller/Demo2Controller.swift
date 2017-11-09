//
//  Demo2Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo2Controller: UIViewController {
    @IBOutlet weak var heartImageV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimation()
    }
}


// MARK: - UI
extension Demo2Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
    }
    
    fileprivate func setupAnimation() {
        let animate = CABasicAnimation(keyPath: "transform.scale")
        animate.toValue = 0
        animate.repeatCount = MAXFLOAT
        animate.autoreverses = true
        heartImageV.layer.add(animate, forKey: nil)
    }
}
