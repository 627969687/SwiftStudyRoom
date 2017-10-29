//
//  FirstWeekOneController.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"

class Demo0Controller: UITableViewController {
    lazy var datas: [AddressGroupModel] = {
        guard let plistPath = Bundle.main.path(forResource: "address1.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        var temp = [AddressGroupModel]()
        for data in dataArr {
            temp.append(AddressGroupModel(dict: data as! [String : Any])) 
        }
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor =
            UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
}

extension Demo0Controller {
    fileprivate func setupUI() {
        self.title = "Contacts"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor =
            UIColor.rgbColor(r: 0, g: 133, b: 255)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: ID)
        tableView.separatorInset = UIEdgeInsetsMake(0, 65, 0, 0)
    }
}

extension Demo0Controller {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datas[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].info.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID) as! AddressCell
        let model = AddressModel(dict: datas[indexPath.section].info[indexPath.row])
        cell.nameLabel.text = model.Name
        cell.iconImage.image = UIImage(named: String(format: "%@.jpg", model.avatar))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = AddressModel(dict: datas[indexPath.section].info[indexPath.row])
        let infoController = InfoController()
        infoController.data = model
        self.navigationController?.pushViewController(infoController, animated: true)
    }
}

