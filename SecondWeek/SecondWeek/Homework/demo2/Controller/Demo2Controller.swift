//
//  Demo2Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
class Demo2Controller: UITableViewController {
    var datas:[TodolistModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }
}

extension Demo2Controller {
    fileprivate func loadData() {
        guard let plistPath = Bundle.main.path(forResource: "todolist.plist", ofType: nil) else {return}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return}

        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let resultPlist = documentPath!+"/todolist.plist"
        if !FileManager.default.fileExists(atPath: resultPlist) {
            dataArr.write(toFile: resultPlist, atomically: true)
        }
        
        guard let result = NSArray(contentsOfFile: resultPlist) else {return}
        
        for data in result {
            datas.append(TodolistModel(dict: data as! [String : Any]))
        }
    }
    
}

// MARK: - UI
extension Demo2Controller {
    fileprivate func setupUI() {
        self.title = "ToDoList"
        tableView.tableFooterView = UIView()
        setupNavItem()
    }
    
    fileprivate func setupNavItem() {
        // left
        let backItem = UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(back))
        let editItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(edit))
        navigationItem.leftBarButtonItems = [backItem,editItem]
        // right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(add))
    }
}

// MARK: - event
extension Demo2Controller {
    @objc fileprivate func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func edit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc fileprivate func add() {
        datas.removeAll()
        navigationController?.pushViewController(AddController(), animated: true)
    }
}

extension Demo2Controller {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: ID)
        }
        cell?.imageView?.image = UIImage(named: String(format: "%@.png", datas[indexPath.row].icon))
        cell?.textLabel?.text = datas[indexPath.row].info
        cell?.detailTextLabel?.text = datas[indexPath.row].date
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let todo = datas.remove(at: fromIndexPath.row)
        datas.insert(todo, at: to.row)
    }

}

