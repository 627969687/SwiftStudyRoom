//
//  Demo2Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
class Demo2Controller: UICollectionViewController {
    lazy var data: [FallModel] = {
        guard let plistPath = Bundle.main.path(forResource: "fall.plist", ofType: nil) else {return []}
        guard let dataArr = NSArray(contentsOfFile: plistPath) else {return []}
        var temp = [FallModel]()
        for data in dataArr {
            temp.append(FallModel(dict: data as! [String : Any]))
        }
        return temp
    }()
    
    var fallLayout:FallLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fallLayout.delegate = self
        setupUI()
    }
    
    init() {
        let margin:CGFloat = 10
        
        fallLayout = FallLayout()
        fallLayout.cols = 2
        fallLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        fallLayout.minimumInteritemSpacing = margin
        fallLayout.minimumLineSpacing = margin
        
        super.init(collectionViewLayout: fallLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UI
extension Demo2Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        collectionView?.register(UINib(nibName: "FallCell", bundle: nil), forCellWithReuseIdentifier: ID)
    }
}

extension Demo2Controller {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! FallCell
        cell.imageView.image = UIImage(named: String(format: "%@.jpg", data[indexPath.row].image))
        return cell
    }
}

extension Demo2Controller:FallLayoutDelegate {
    func fallLayoutSizeForItemAtIndex(layout: FallLayout, index: Int) -> CGSize {
        let size = CGSize(width: data[index].width, height: data[index].height)
        return size
    }
}

