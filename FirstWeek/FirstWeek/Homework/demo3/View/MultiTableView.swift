//
//  MultiTableViewController.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/22.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
fileprivate let headerID = "head"

// MARK: - 回调Block
typealias SectionTopGesClick = (_ obj: Any) -> Swift.Void   // 组头部回调
typealias LeafClick = () -> Swift.Void

// MARK: - 组头部
// MARK: 手势
class SectionTopGes: UITapGestureRecognizer {
    var click:SectionTopGesClick!
    
    class func addGesture(view:UIView,action:@escaping SectionTopGesClick) {
        let tap = SectionTopGes()
        tap.click = action
        tap.addTarget(tap, action: #selector(SectionTopGes.tapClick(_:)));
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapClick(_ tap : UITapGestureRecognizer){
        if (self.click != nil){
            self.click!(tap.view!)
        }
    }
}

// MARK: view
class SectionHeaderView: UITableViewHeaderFooterView {
    var detailLabel: UILabel!
    var selBtn:UIButton!
    var bgv:UIView!
    
    var click:SectionTopGesClick!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bgv = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 50))
        bgv.backgroundColor = UIColor.rgbColor(0, A: 0.3)
        bgv.layer.borderWidth = 1.0
        bgv.layer.cornerRadius = 5
        bgv.layer.masksToBounds = true

        let selBtnWH:CGFloat = 30
        selBtn = UIButton(frame: CGRect(x: bgv.width() - selBtnWH, y: (bgv.height() - selBtnWH) * 0.5, width: selBtnWH, height: selBtnWH))
        selBtn.isUserInteractionEnabled = false
        selBtn.setTitle("+", for: .normal)
        selBtn.setTitle("-", for: .selected)
        selBtn.setTitleColor(UIColor.blue, for: .normal)
        bgv.addSubview(selBtn)
        
        detailLabel = UILabel(frame: CGRect(x: 10, y: 0, width: bgv.width() - 10 - selBtnWH, height: bgv.height()))
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textColor = UIColor.black
        detailLabel.textAlignment = NSTextAlignment.left
        detailLabel.backgroundColor = UIColor.clear
        bgv.addSubview(detailLabel)
        
        self.contentView.addSubview(bgv)
        
        SectionTopGes.addGesture(view: bgv) { (obj) in
            if self.click != nil { self.click(obj) }
        }
    }
    
    func setInfo(_ obj:RootModel) {
        detailLabel?.text = obj.info
        selBtn.isSelected = obj.isOpen
    }
}

// MARK: - 多列表tableview
class MultiTableView: UITableView {
    var rootNodes:[RootModel] = []
    var subNodes:[[SubModel]] = [] // 数组套数组
    var reloadArray:[IndexPath] = []
    var leafClick:LeafClick!
    var isPreservation = false // 收起后再展开是否保留之前的展开状态
    var isInitialized = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.white
        self.tableFooterView = UIView()
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.register(NodeCell.self, forCellReuseIdentifier: ID)
        self.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: headerID)
        isInitialized = true
    }
    
    convenience init(frame : CGRect ,needPreservation : Bool, datas : [RootModel]?) {
        self.init(frame: frame, style: UITableViewStyle.grouped)
        if datas != nil {
            rootNodes = datas!
        }
        for _ in 0 ..< rootNodes.count {
            subNodes.append([SubModel]())
        }
        isPreservation = needPreservation
        isInitialized = true
    }

}

// MARK: - Table view data source
extension MultiTableView:UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return rootNodes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subNodes[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! SectionHeaderView
        let rootNode = rootNodes[section]
        head.setInfo(rootNode)
        head.click = { (obj) in
            rootNode.isOpen = !rootNode.isOpen
            print(rootNode.isOpen)
            if rootNode.isOpen {    // 记录展开数据
                _ = self.recordExpandData(section: section, rootID: rootNode.id, index: -1)
            } else {
                self.subNodes[section].removeAll()
            }
            self.reloadArray.removeAll()
            tableView.reloadSections(IndexSet(integer: section), with: UITableViewRowAnimation.automatic)
        }
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! NodeCell
        let obj = subNodes[indexPath.section][indexPath.row]
        cell.setInfo(obj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentnode = subNodes[indexPath.section][indexPath.row]
        if currentnode.isLeaf {
            print("点击叶子,\(currentnode.info)")
            if self.leafClick != nil {
                self.leafClick()
            }
            return
        }else{
            currentnode.isOpen = !currentnode.isOpen
        }
        reloadArray.removeAll()
        
        if currentnode.isOpen {
            _ = self.recordExpandData(section: indexPath.section, rootID: currentnode.ownID, index: indexPath.row)
            //插入cell
            tableView.insertRows(at: reloadArray as [IndexPath], with: UITableViewRowAnimation.none)
        }else{
            print(currentnode.level)
            self.recordFoldNodes(section: indexPath.section, level: currentnode.level, currentIndex: indexPath.row)
            //删除cell
            tableView.deleteRows(at: reloadArray, with: UITableViewRowAnimation.none)
        }
        //刷新这行cell的显示
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }

}

// MARK: - 记录数据
extension MultiTableView {
    //// 展开
    func recordExpandData(section : Int, rootID:String,index:Int) -> Int {
        var insertindex = index
        
        for i in 0 ..< rootNodes[section].subNodes.count {
            let node = rootNodes[section].subNodes[i]
            // 找到父节点是rootID的子节点
            if node.rootID == rootID {
                if !self.isPreservation {  //是否保留所有子cell的展开状态
                    node.isOpen = false
                }
                // 展开节点的后面+1的位置
                insertindex += 1
                // 根据展开顺序排列
                subNodes[section].insert(node, at: insertindex)
                // 存储插入的位置
                reloadArray.append(IndexPath(row: insertindex, section: section))
                // 遍历子节点的子节点进行展开
                if node.isOpen {
                    insertindex = recordExpandData(section : section, rootID: node.ownID, index: insertindex)
                }
            }
        }
        return insertindex
    }
    
    //// 收起
    func recordFoldNodes(section : Int,level:Int,currentIndex:Int){
        if currentIndex+1 < subNodes[section].count {
            
            let tempArr = NSArray(array: subNodes[section])
            
            let startI = currentIndex+1
            var endI   = currentIndex
            for i in (currentIndex+1)..<(tempArr.count) {
                let node = tempArr[i] as! SubModel
                if node.level <= level {
                    break
                }else{
                    endI += 1
                    reloadArray.append(IndexPath(row: i, section: section))
                }
            }
            if endI >= startI {
                subNodes[section].removeSubrange(startI...endI)
            }
        }
    }

}
