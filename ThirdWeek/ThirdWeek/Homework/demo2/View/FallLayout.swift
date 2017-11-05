//
//  FallLayout.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/4.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

protocol FallLayoutDelegate : class {
    func fallLayoutSizeForItemAtIndex(layout:FallLayout,index:Int) -> CGSize
}

class FallLayout: UICollectionViewLayout {
    weak var delegate : FallLayoutDelegate!
    
    var minimumLineSpacing:CGFloat = 0 // 充当行间距
    var minimumInteritemSpacing:CGFloat = 0 // 充当列间距
    var sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
    var cols = 2
    
    fileprivate var attrsArray = [UICollectionViewLayoutAttributes]()
    fileprivate var colsHeights = [CGFloat]()
    fileprivate var contentHeight:CGFloat = 0
    
    // 哪一列最短，下一个item就放在哪一列
    
    override var collectionViewContentSize: CGSize {
        get {
            // 高度 = 最长的一列的高度和间距之和
            return CGSize(width: collectionView!.width(), height: contentHeight + sectionInset.bottom)
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
}

extension FallLayout {
    override func prepare() {
        super.prepare()
        
        contentHeight = 0
        colsHeights.removeAll()
        for _ in 0..<cols {
            colsHeights.append(sectionInset.top)
        }
        
        attrsArray.removeAll()
        guard let itemCount = collectionView?.numberOfItems(inSection: 0) else {return}
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            guard let attrs = layoutAttributesForItem(at: indexPath) else {continue}
            attrsArray.append(attrs)
        }
    }
}

extension FallLayout {
    // 修改坐标
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//        guard let width = collectionView?.width() else {return attribute}
        
        // 获取最短高度的一列
        var destCol = 0
        var minColHeight = colsHeights[0]
        for i in 0..<cols {
            let colHeight = colsHeights[i]
            if minColHeight > colHeight {
                minColHeight = colHeight
                destCol = i
            }
        }
        
        let size = delegate.fallLayoutSizeForItemAtIndex(layout: self, index: indexPath.row)
        let w:CGFloat = size.width
        let h:CGFloat = size.height
        let x = sectionInset.left + CGFloat(destCol) * (w+minimumInteritemSpacing)
        var y = minColHeight
        if y != sectionInset.top {
            y = y + minimumLineSpacing
        }
        
        attribute.frame = CGRect(x: x, y: y, width: w, height: h)
        // 更新每列高度
        colsHeights[destCol] = attribute.frame.maxY
        
        if contentHeight < attribute.frame.maxY {
            contentHeight = attribute.frame.maxY
        }
        
        return attribute
    }
    
    // 返回item个数
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
}

