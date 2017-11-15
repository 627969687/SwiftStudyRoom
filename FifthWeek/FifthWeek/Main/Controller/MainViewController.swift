//
//  MainViewController.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    fileprivate lazy var homeworkList:[HomeworkModel] = [HomeworkModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }
}

// MARK: - 数据源
extension MainViewController {
    fileprivate func loadData() {
        guard let plistPath = Bundle.main.path(forResource: "homework.plist", ofType: nil) else { return }
        guard let datas = NSArray(contentsOfFile: plistPath) as? [[String:Any]] else {return}
        for dict in datas {
            homeworkList.append(HomeworkModel(dict: dict))
        }
    }
}

// MARK: - UI
extension MainViewController {
    fileprivate func setupUI() {
        tableView.tableFooterView = UIView()
    }
}

// MARK: - <UITableViewDelegate,UITableViewDataSource>
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = homeworkList[indexPath.row].project
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // swift的NSClassFromString要加上项目名.
        guard let project = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {return}
        let controlName = String(format: "Demo%dController",indexPath.row)
        
        let vc = NSClassFromString(project+"."+controlName) as! UIViewController.Type
        let tarVC = vc.init()
        tarVC.title = homeworkList[indexPath.row].project.substringFrom("-")
        self.navigationController?.pushViewController(tarVC, animated: true)
    }
}
