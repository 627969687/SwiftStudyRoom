//
//  NodeCell.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/22.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class NodeCell: UITableViewCell {
    var detailLabel   : UILabel!
    var selBtn:UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setInfo(_ obj:AnyObject) {
        let obj = obj as! SubModel
        detailLabel.text = obj.info
        selBtn.isSelected = obj.isOpen
        selBtn.isHidden = obj.isLeaf
        layoutView(obj)
    }
}

extension NodeCell {
    func setupUI() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        let selBtnWH:CGFloat = 30
        selBtn = UIButton(frame: CGRect(x: self.contentView.width() - selBtnWH, y: (self.contentView.height() - selBtnWH) * 0.5, width: selBtnWH, height: selBtnWH))
        selBtn.isUserInteractionEnabled = false
        selBtn.setTitle("+", for: .normal)
        selBtn.setTitle("-", for: .selected)
        selBtn.setTitleColor(UIColor.blue, for: .normal)
        self.contentView.addSubview(selBtn)
        
        detailLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.contentView.width() - 10 - selBtnWH, height: self.contentView.height()))
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        detailLabel.textColor = UIColor.black
        detailLabel.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(detailLabel)
        self.contentView.backgroundColor = UIColor.rgbColor(245, A: 1.0)
    }
    
    func layoutView(_ obj : SubModel){
        let interval : CGFloat = 30
        var leMargin : CGFloat = 10
        for _ in 2...obj.level {
            leMargin += interval
        }
        
        detailLabel.frame = CGRect(x: leMargin, y: 0, width: self.contentView.width() - leMargin - 30, height: self.contentView.height())
        self.contentView.backgroundColor = obj.level == 2 ? UIColor.rgbColor(245, A: 1.0) : UIColor.rgbColor(255, A: 1.0)
    }

}
