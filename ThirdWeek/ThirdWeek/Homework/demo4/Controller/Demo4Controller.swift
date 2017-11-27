//
//  Demo4Controller.swift
//  ThirdWeek
//
//  Created by 荣 Jason on 2017/11/1.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

fileprivate let ID = "cell"
class Demo4Controller: UICollectionViewController {
    
    var selectedCell:TransitionCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screenW * 0.5, height: screenW * 0.5)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Demo4Controller {
    fileprivate func setupUI() {
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView?.register(UINib(nibName: "TransitionCell", bundle: nil), forCellWithReuseIdentifier: ID)
    }
}

// MARK: - collectionview delegate
extension Demo4Controller {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! TransitionCell
        cell.imageView.image = UIImage(named: String(format: "transition%d.jpg", indexPath.item + 1))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let control = TransitionController()
        control.image = UIImage(named: String(format: "transition%d.jpg", indexPath.item + 1))!
        selectedCell = collectionView.cellForItem(at: indexPath) as! TransitionCell
        navigationController?.pushViewController(control, animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
// 自定义转场动画必须实现的代理
extension Demo4Controller:UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushAnim()
        }
        return nil
    }
}

