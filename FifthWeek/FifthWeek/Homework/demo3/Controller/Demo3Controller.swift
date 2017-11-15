//
//  Demo3Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo3Controller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension Demo3Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.black
        print("test")
        let margin:CGFloat = 100
        let loadingV = LoadingView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenW - margin, height: screenW - margin)), colors: [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)])
        loadingV.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0)
        loadingV.center = view.center
        view.addSubview(loadingV)
    }
}






