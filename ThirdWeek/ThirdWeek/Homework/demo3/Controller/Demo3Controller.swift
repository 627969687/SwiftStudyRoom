//
//  Demo3Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let menuID = "menu"
fileprivate let contentID = "content"

class Demo3Controller: UIViewController {
    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var contentView: UICollectionView!
    
    lazy var menuData: [SeafoodModel] = {
        guard let plistPath = Bundle.main.path(forResource: "Seafood.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        var temp = [SeafoodModel]()
        for data in dataArr {
            temp.append(SeafoodModel(dict: data as! [String : Any]))
        }
        return temp
    }()
    
//    lazy var contentData: [ContentModel] = {
//        var temp = [ContentModel]()
//        for data in menuData[0].info {
//            temp.append(ContentModel(dict: data))
//        }
//        return temp
//    }()
    var contentData = [ContentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension Demo3Controller {
    fileprivate func setupUI() {
        setupMenu()
        setupContent()
    }
    
    fileprivate func setupMenu() {
        menuView.tableFooterView = UIView()
        menuView.register(UITableViewCell.self, forCellReuseIdentifier: menuID)
        
        menuView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        self.tableView(menuView, didSelectRowAt: IndexPath(row: 0, section: 0))

    }
    
    fileprivate func setupContent() {
        contentView.register(UINib(nibName: "SeafoodCell", bundle: nil), forCellWithReuseIdentifier: contentID)
    }
}

// MARK: - tablview delegate datasource
extension Demo3Controller:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuID)
        cell?.textLabel?.text = menuData[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentData.removeAll()
        for data in menuData[indexPath.row].info {
            contentData.append(ContentModel(dict: data))
        }
        contentView.reloadData()
    }
}

// MARK: - collection delegate datasource
extension Demo3Controller:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentID, for: indexPath) as! SeafoodCell
        cell.imageView.image = #imageLiteral(resourceName: "bolong.jpg")
        cell.label.text = contentData[indexPath.row].name
        return cell
    }
}






