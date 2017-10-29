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
    lazy var datas: [CardModel] = {
        guard let plistPath = Bundle.main.path(forResource: "card.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        var temp = [CardModel]()
        for data in dataArr {
            temp.append(CardModel(dict: data as! [String : Any]))
        }
        return temp
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screenW * 0.8, height: screenH * 0.5)
        flowLayout.minimumLineSpacing = 25
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 0)
        flowLayout.scrollDirection = .horizontal
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension Demo1Controller {
    fileprivate func setupUI() {
        self.title = "CardTable"
        collectionView?.layer.contents = UIImage(named: "cardBg.jpg")?.cgImage
        collectionView?.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: ID)
    }
    
}

extension Demo1Controller {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! CardCell
        cell.titleLabel.text = datas[indexPath.row].title
        cell.imgView.image = UIImage(named: String(format: "%@.jpg", datas[indexPath.row].img))
        return cell
    }

}




