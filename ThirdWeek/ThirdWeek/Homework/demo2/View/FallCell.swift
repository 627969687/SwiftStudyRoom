//
//  FallCell.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/4.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class FallCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }

}
