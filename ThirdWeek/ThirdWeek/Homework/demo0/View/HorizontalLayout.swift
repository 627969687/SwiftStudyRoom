//
//  HorizontalLayout.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/2.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class HorizontalLayout: UICollectionViewLayout {
    var minimumLineSpacing:CGFloat = 0
    var minimumInteritemSpacing:CGFloat = 0
    var itemSize = CGSize(width: 50, height: 50)
    var sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
    
    fileprivate var pageNum = 0
    fileprivate var eachCols = 0 // 每页列数
    fileprivate var eachRows = 0 // 每页行数
    
    // MARK: 计算内容尺寸
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: CGFloat(pageNum) * collectionView!.width(), height: collectionView!.height())
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 计算行数、列数、页数
extension HorizontalLayout {
    override func prepare() {
        super.prepare()
        // collectionView 尺寸
        guard let width = collectionView?.width() else { return }
        guard let height = collectionView?.height() else { return }
        
        let contentW = width - sectionInset.left - sectionInset.right
        let contentH = height - sectionInset.top - sectionInset.bottom
        
        /** 列
         公式：collectionView当前内容宽度 = 当前列数 * item宽 + (列数 - 1) * 间距
         */
        eachCols = Int((contentW + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing))
        
        /** 行
         公式：collectionView当前内容高度 = 当前行数 * item高 + (行数 - 1) * 间距
         */
        eachRows = Int((contentH + minimumLineSpacing) / (itemSize.height + minimumLineSpacing))
        
        /** 页
         itemCount - 1，避免相等情况
         */
        guard let itemCount = (collectionView?.numberOfItems(inSection: 0)) else { return }
        pageNum = (itemCount - 1) / (eachCols*eachRows) + 1
        
    }
}

// MARK: - 修改item属性
extension HorizontalLayout {
    // 计算坐标
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let width = itemSize.width
        let height = itemSize.height
        let curNum = indexPath.row
        let eachNum = eachCols * eachRows
        
        // 九宫格运算
        let curCol = curNum % eachCols
        var curRow = curNum / eachCols
        if curNum >= eachNum {
            curRow = curNum % eachNum / eachCols
        }
        let curPage = curNum / eachNum
        
        let x:CGFloat = CGFloat(curCol) * (width+minimumInteritemSpacing) + sectionInset.left + CGFloat(curPage) * collectionView!.width()
        let y:CGFloat = CGFloat(curRow) * (height+minimumLineSpacing) + sectionInset.top
        
        attributes.frame.size = itemSize
        attributes.frame.origin = CGPoint(x: x, y: y)
        return attributes
    }

    // 返回item个数
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var temp:[UICollectionViewLayoutAttributes] = []
        for i in 0..<collectionView!.numberOfSections { // 每组
            let items = collectionView!.numberOfItems(inSection: i)
            for j in 0..<items { // 每行
                temp.append(layoutAttributesForItem(at: IndexPath(item: j, section: i))!)
            }
        }
        return temp
    }
}

