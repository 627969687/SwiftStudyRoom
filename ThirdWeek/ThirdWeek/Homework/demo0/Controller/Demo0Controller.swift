//
//  FirstWeekOneController.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

// 一页8个，间距为10
// 顺序为从左至右排列

import UIKit

fileprivate let ID = "cell"
class Demo0Controller: UIViewController {
    let itemCount = 11
    
    lazy var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.currentPageIndicatorTintColor = UIColor.green
        temp.pageIndicatorTintColor = UIColor.red
        temp.sizeToFit()
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension Demo0Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        
        let cols = 4
        let rows = 2
        let margin:CGFloat = 10
        let itemWH = (screenW - (CGFloat(cols)+1) * margin) / CGFloat(cols)
        
        // collection尺寸
        let width = screenW
        let height = itemWH * CGFloat(rows) + margin * (CGFloat(rows)+1)
        
        let flowLayout = HorizontalLayout()
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: width, height: height), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.green
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ID)
        
        
        pageControl.numberOfPages = (itemCount-1) / (cols*rows) + 1
        pageControl.setY(y: collectionView.maxY() + 8)
        pageControl.setCenterX(centerX: screenW * 0.5)
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    }
}

extension Demo0Controller:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! CollectionViewCell
        cell.label.text = String(format: "%d", indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNum = Int((scrollView.contentOffset.x / scrollView.width()) + CGFloat(0.5))
        pageControl.currentPage = pageNum
    }
}



