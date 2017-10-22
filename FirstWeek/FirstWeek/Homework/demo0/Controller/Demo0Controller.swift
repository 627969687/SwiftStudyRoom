//
//  FirstWeekOneController.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo0Controller: UIViewController {
    // MARK: 属性
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    var moneyCount: Float = 0.0
    
    // MARK: 懒加载
    lazy var keyboadrBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.isHidden = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI
extension Demo0Controller {
    fileprivate func setupUI() {
        self.title = "Tip Calculator"
        change()
    }
    
    fileprivate func change() {
        tipPercentSlider.addTarget(self, action: #selector(percentSliderChange), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardPopup), name: .UIKeyboardDidShow, object: nil)
    }
    
    @objc fileprivate func percentSliderChange() {
        let tipPercent = Int(tipPercentSlider.value * 100)
        tipPercentLabel.text = String(format: "Tip(%%%d)", tipPercent)
        tipLabel.text = String(format: "$%.2f", tipPercentSlider.value * moneyCount)
        totalLabel.text = String(format: "$%.2f", moneyCount + (tipPercentSlider.value * moneyCount))
    }
    
    @objc fileprivate func keyboardPopup(notification:Notification) {
        let info = notification.userInfo
        let frame = info![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let height = frame.size.height
        
        keyboadrBtn.setTitle("完成", for: .normal)
        keyboadrBtn.isHidden = false
        keyboadrBtn.sizeToFit()
        keyboadrBtn.setX(x:screenW - keyboadrBtn.width())
        keyboadrBtn.setY(y: screenH - height - keyboadrBtn.height())
        keyboadrBtn.addTarget(self, action: #selector(moneyEdited), for: .touchUpInside)
    }
    
    @objc fileprivate func moneyEdited() {
        keyboadrBtn.isHidden = true
        view.endEditing(true)
        
        moneyCount = (moneyTF.text! as NSString).floatValue
        tipLabel.text = String(format: "$%.2f", tipPercentSlider.value * moneyCount)
        totalLabel.text = String(format: "$%.2f", moneyCount + (tipPercentSlider.value * moneyCount))
    }
}






