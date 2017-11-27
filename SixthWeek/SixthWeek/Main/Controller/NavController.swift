//
//  NavController.swift
//  SixthWeek
//
//  Created by 荣 Jason on 2017/11/20.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
        
        set {
            self.shouldAutorotate = newValue
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if (topViewController?.isKind(of: Demo0Controller.self))! {
                return .landscape
            }
            return .all
        }
        
        set {
            self.supportedInterfaceOrientations = newValue
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: Demo0Controller.self) {
            forceRotation(orient: .landscapeLeft)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            forceRotation(orient: .portrait)
        }
        return super.popViewController(animated: animated)
    }
}

// MARK: - 强制转屏
extension NavController {
    fileprivate func forceRotation(orient:UIDeviceOrientation) {
        let sel = NSSelectorFromString("setOrientation:")
        if UIDevice.current.responds(to: sel) {
            UIDevice.current.setValue(orient.rawValue, forKey: "orientation")
        }
    }
}
