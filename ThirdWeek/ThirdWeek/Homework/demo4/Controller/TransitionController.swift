//
//  TransitionController.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/8.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class TransitionController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
