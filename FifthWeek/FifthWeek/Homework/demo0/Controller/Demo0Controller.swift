//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo0Controller: UIViewController {
    @IBOutlet weak var bgView: BGView!
    @IBOutlet weak var valueTF: UITextField!
    @IBOutlet weak var percentLabel: UILabel!
    
    lazy var timer: DispatchSourceTimer = {
        let temp = DispatchSource.makeTimerSource(flags: [], queue: .main)
        temp.schedule(deadline: .now(), repeating: .milliseconds(10), leeway: .never)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UI
extension Demo0Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
    }
}

extension Demo0Controller {
    @IBAction func animClick() {
        timer.setEventHandler {
            guard let valueStr = self.valueTF.text else {return}
            guard let value = NumberFormatter().number(from: valueStr) else {return}

            if CGFloat(truncating: value) <= self.bgView.progress*100 ||  CGFloat(truncating: value) > 100.0 {
                self.timer.suspend()
                return
            }

            self.bgView.progress = self.bgView.progress + 0.01
            self.percentLabel.text = String(format: "%.1lf%%", self.bgView.progress*100)
            self.bgView.setNeedsDisplay()
        }
        timer.resume()
    }
}






