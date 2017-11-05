//
//  InfoController.swift
//  SecondWeek
//
//  Created by 荣 Jason on 2017/10/29.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"

class InfoController: UITableViewController {
    var data:AddressModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension InfoController {
    fileprivate func setupUI() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(InfoCell.self, forCellReuseIdentifier: ID)
    }
}

extension InfoController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let iconImageV = UIImageView(frame: CGRect(x: 15, y: 15, width: 80, height: 80))
        iconImageV.image = UIImage(named: String(format: "%@.jpg", data.avatar))
        iconImageV.layer.cornerRadius = 40
        iconImageV.layer.masksToBounds = true
        view.addSubview(iconImageV)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var info = ""
        switch indexPath.row {
        case 0:
            info = data.Name
            break
        case 1:
            info = data.Mobile.mobileFormat(4)
            break
        case 2:
            info = data.Email
            break
        case 3:
            info = data.Notes
        default:
            break
        }
        return info.heightWithConstrainedWidth(width: screenW - 15, font: UIFont.systemFont(ofSize: 17)) + 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID) as! InfoCell
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Name"
            cell.infoLabel.text = data.Name
            cell.infoLabel.font = UIFont.boldSystemFont(ofSize: 16)
            break
        case 1:
            cell.nameLabel.text = "Mobile"
            cell.infoLabel.text = data.Mobile.mobileFormat(4)
            break
        case 2:
            cell.nameLabel.text = "Email"
            cell.infoLabel.text = data.Email
            break
        case 3:
            cell.nameLabel.text = "Notes"
            cell.infoLabel.text = data.Notes
        default:
            break
        }
        cell.nameLabel.sizeToFit()
        cell.infoLabel.setHeight(height: cell.infoLabel.text!.heightWithConstrainedWidth(width: cell.infoLabel.width(), font: UIFont.systemFont(ofSize: 17)))
        cell.infoLabel.setY(y: cell.nameLabel.height() + 5)
        return cell
    }
}


class InfoCell: UITableViewCell {
    var nameLabel:UILabel!
    var infoLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let leftMargin:CGFloat = 15
        
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.blue
        nameLabel.setX(x: leftMargin)
        
        infoLabel = UILabel(frame: CGRect(x: leftMargin, y: 0, width: contentView.width() - leftMargin, height: contentView.height()))
        infoLabel.numberOfLines = 0
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
