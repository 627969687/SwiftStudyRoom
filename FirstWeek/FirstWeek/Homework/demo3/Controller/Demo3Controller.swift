//
//  Demo3Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//


// 点击一个cell重新追加一个tableview？

import UIKit

class Demo3Controller: UIViewController {
    
    fileprivate lazy var data: AnyObject! = {
        guard let plistPath = Bundle.main.path(forResource: "territory.plist", ofType: nil) else {return nil}
        guard let plistData = NSArray(contentsOfFile: plistPath) else {return nil}
        return getdata(obj: plistData)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(data)
        setupUI()
    }
}

extension Demo3Controller {
    fileprivate func getdata(obj:AnyObject) -> AnyObject! {
        guard let objs = obj as? NSArray else {return nil}
        var datas = [AnyObject]()
        
        // 洲
        for continentObj in objs {
            guard let continentDict = continentObj as? NSDictionary else {return nil}
            guard let continentID = continentDict["continentID"] as? String else {return nil}
            guard let continentName = continentDict["洲"] as? String else {return nil}
            let continentModel = RootModel.node(id: continentID, info: continentName)
            datas.append(continentModel)
            
            // 将所有子孙节点加入到根节点的子节点数组中
            // 国家
            guard let countryArr = continentDict["国家"] as? NSArray else {return nil}
            for countryObj in countryArr {
                guard let countryDict = countryObj as? NSDictionary else {return nil}
                guard let countryID = countryDict["countryID"] as? String else {return nil}
                guard let countryName = countryDict["国家名称"] as? String else {return nil}
                let countryModel = SubModel.node(rootID: continentID, ownID: countryID, info: countryName, level: 2, isOpen: false, isLeaf: false)
                continentModel.subNodes.append(countryModel)
                
                // 城市
                guard let cityArr = countryDict["城市"] as? NSArray else {return nil}
                for cityObj in cityArr {
                    guard let cityDict = cityObj as? NSDictionary else {return nil}
                    guard let cityID = cityDict["cityID"] as? String else {return nil}
                    guard let cityName = cityDict["城市名称"]as? String else {return nil}
                    let cityModel = SubModel.node(rootID: countryID, ownID: cityID, info: cityName, level: 3, isOpen: false, isLeaf: true)
                    continentModel.subNodes.append(cityModel)
                }
            }
        }
        return datas as AnyObject
    }
}

extension Demo3Controller {
    fileprivate func setupUI() {
        let multiTableView = MultiTableView(frame: CGRect(x: 0, y: 50, width: view.width(), height: view.height() - 50), needPreservation: true, datas: data as? [RootModel])
        view.addSubview(multiTableView)
    }
}
