//
//  AddController.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    @IBOutlet weak var talkBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var airBtn: UIButton!
    @IBOutlet weak var ToDoTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var sel = "talk"
    
    lazy var datas: [[String:Any]] = {
        guard let plistPath = Bundle.main.path(forResource: "todolist.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        return dataArr as! [[String : Any]]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AddController {
    @IBAction func talkClick(_ sender: Any) {
        talkBtn.isSelected = true
        phoneBtn.isSelected = false
        shopBtn.isSelected = false
        airBtn.isSelected = false
        sel = "talk"
    }
    
    @IBAction func phoneClick(_ sender: Any) {
        talkBtn.isSelected = false
        phoneBtn.isSelected = true
        shopBtn.isSelected = false
        airBtn.isSelected = false
        sel = "phone"
    }
    
    @IBAction func shopClick(_ sender: Any) {
        talkBtn.isSelected = false
        phoneBtn.isSelected = false
        shopBtn.isSelected = true
        airBtn.isSelected = false
        sel = "shop"
    }
    
    @IBAction func airClick(_ sender: Any) {
        talkBtn.isSelected = false
        phoneBtn.isSelected = false
        shopBtn.isSelected = false
        airBtn.isSelected = true
        sel = "air"
    }
    
    @IBAction func doneClick(_ sender: Any) {
        change()
        navigationController?.popViewController(animated: true)
    }
}

extension AddController {
    fileprivate func change() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        let result:[String:Any] = ["info":ToDoTF.text!,
                      "date":dateFormat.string(from: datePicker.date),
                      "icon":sel]
        datas.append(result)
        let resultArr = datas as NSArray
        resultArr.write(toFile: Bundle.main.bundlePath+"/todolist.plist", atomically: true)
    }
}
