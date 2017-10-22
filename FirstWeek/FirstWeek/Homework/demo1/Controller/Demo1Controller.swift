//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"

class Demo1Controller: UITableViewController {
    lazy var datas:[NameModel] = {
        guard let plistPath = Bundle.main.path(forResource: "names.plist", ofType: nil) else {return []}
        guard let datas = NSArray(contentsOfFile: plistPath) as? [[String:Any]] else {return []}
        var temp = [NameModel]()
        for dict in datas {
            temp.append(NameModel(dict: dict))
        }
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI
extension Demo1Controller {
    fileprivate func setupUI() {
        self.title = "NameList"
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ID)
    }
}

extension Demo1Controller {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datas[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ID) else { return UITableViewCell(style: .default, reuseIdentifier: ID) }
        cell.textLabel?.text = datas[indexPath.section].names[indexPath.row]
        return cell
    }
    
    // 索引
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var temp = [String]()
        for model in datas {
            temp.append(model.title)
        }
        return temp
    }
}




