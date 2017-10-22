//
//  Demo2Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo2Controller: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer: Timer!    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - UI
extension Demo2Controller {
    fileprivate func setupUI() {
        self.title = "StopWatch"
    }
}

// MARK: - action
extension Demo2Controller {
    @IBAction func resetClick(_ sender: Any) {
        timeLabel.text = "0.0"
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    @IBAction func startClick(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(valueChange), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func valueChange() {
        guard var time = (self.timeLabel.text as NSString?)?.floatValue else {return}
        time = time + 0.1
        timeLabel.text = String(format: "%.1f",time)
    }
    
    @IBAction func stopClick(_ sender: Any) {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
}
