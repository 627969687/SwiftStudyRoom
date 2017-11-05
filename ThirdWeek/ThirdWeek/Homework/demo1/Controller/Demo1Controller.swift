//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
class Demo1Controller: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init() {
        let margin:CGFloat = 10
        let itemWH:CGFloat = (screenW - 3 * margin) / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension Demo1Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        collectionView?.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: ID)
    }
}

extension Demo1Controller {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! ImageCell
        cell.imageView.image = UIImage(named: String(format: "test%d.jpg", indexPath.row+1))
        return cell
    }
}





