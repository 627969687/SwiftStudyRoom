//
//  Demo3Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
class Demo3Controller: UITableViewController {
    lazy var datas: [EditModel] = {
        guard let plistPath = Bundle.main.path(forResource: "edit.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        var temp = [EditModel]()
        for data in dataArr {
            temp.append(EditModel(dict: data as! [String : Any]))
        }
        return temp
    }()

    lazy var shareAlertControl: UIActivityViewController = {
        let activityControl = UIActivityViewController(activityItems: [
            UIActivityType.postToTencentWeibo,
            UIActivityType.copyToPasteboard,
            UIActivityType.postToWeibo,
            UIActivityType.copyToPasteboard,
            UIActivityType.postToVimeo
            ], applicationActivities: nil)
        return activityControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension Demo3Controller {
    fileprivate func setupUI() {
        self.title = "SwipeableCell"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "EditCell", bundle: nil), forCellReuseIdentifier: ID)
    }
}

extension Demo3Controller {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID) as! EditCell
        cell.nameLabel.text = datas[indexPath.row].name
        cell.imgView.image = UIImage(named: String(format: "%@.jpg", datas[indexPath.row].img))
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delAction = UITableViewRowAction(style: .destructive, title: "🗑️\nDelete") { (action, indexpath) in
            
        }
        let shareAction = UITableViewRowAction(style: .destructive, title: "🤗\nShare") { (action, indexpath) in
            self.present(self.shareAlertControl, animated: true, completion: nil)
        }
        let downloadAction = UITableViewRowAction(style: .destructive, title: "⬇️\nDownload") { (action, indexpath) in
            
        }
        return [delAction,shareAction,downloadAction]
    }
}





